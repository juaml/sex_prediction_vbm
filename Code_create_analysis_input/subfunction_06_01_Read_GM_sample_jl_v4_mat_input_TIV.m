
function subfunction_06_01_Read_GM_sample_jl_v4_mat_input_TIV(savedir, tbpath,tb,outf,glob_mask_path, glob_mask_str)

addpath('/data/group/brainvar/Tools/spm12')

s = load(fullfile(tbpath,tb));

% zz_nr = s.zz_nr; 

% female = 1
sex_list= s.big_table.sex;
sex = strcmp(sex_list,'F'); 

age_list = s.big_table.age; 
age = [age_list{:}]; 

gmv_list = s.big_table.GMV; 
GMV = [gmv_list{:}]; 

TIV_list = s.big_table.TIV; 
TIV = [TIV_list{:}];

% som_groe = s.som_groe;
% som_gew = s.som_gew; 
% TIV = s.TIV; 
% GM = s.GM; 
% WM = s.WM; 
% CSF = s.CSF; 
% IQR = s.IQR; 

sub_list = s.big_table.Subject;
Subject = char(sub_list); 
path_list = s.big_table.Path;
Path = char(path_list); 

ispat_list= s.big_table.isPatient;
isPatient = cell2mat(ispat_list) == 1;
%isPatient = strcmp(ispat_list,'1'); 

sample_list = s.big_table.Sample_site;
sample_0x2F_site = char(sample_list); 


for i=1:numel(isPatient)
  
    %if strcmpi(isPatient(i,1),'1')
    if isPatient(i,1) == 1
        isPat(i) = 1;
    else
        isPat(i) = 0;
    end
    
    % might need to be adapted 
    
    
%     sub{i}    = strrep(strrep(Subject(i,:),'s',''),' ','');
    sub{i}    = strrep(Subject(i,:),' ','');
    SubDir{i} = strrep(sample_0x2F_site(i,:),' ','');
    posUS = strfind(SubDir{i},'_');
    if numel(posUS>0)
        Site{i} = SubDir{i}(1:posUS(end)-1);
    else
        Site{i} = SubDir{i};
    end
    if numel(strfind(SubDir{i},'open_fmri'))>0
        Site{i} = 'OpenfMRI';
    end        
    if numel(strfind(SubDir{i},'/'))>0
        posUS = strfind(SubDir{i},'/');
        Site{i} = SubDir{i}(1:posUS(end)-1);
    end
    
    Ses{i} = '';
    
    % check
    Female(i) = sex(i);
    
    Age(i) = age(i);
    
    try
        Vi(i) = spm_vol(Path(i,:));
        
        Q(i) = true;
    catch
        Q(i) = false;
    end
    
    disp(i)
end

GLMFlags.sub = sub;
GLMFlags.SubDir = SubDir;
GLMFlags.Age = Age;
GLMFlags.GMV = GMV;
GLMFlags.TIV = TIV;
GLMFlags.Female = Female;
GLMFlags.Site = Site;
GLMFlags.Ses = Ses;
GLMFlags.Vi = Vi;
%GLMFlags.isPat = zeros(1,numel(Age));
GLMFlags.isPat = isPat;

save(fullfile(savedir,['Setup_',outf,'.mat']),'GLMFlags','-v7.3')

clc, 
% clear
load(fullfile(savedir,['Setup_',outf,'.mat']))
%load([savedir,['Setup_',outf],'.mat'])

Vi = GLMFlags.Vi;
GLMFlags = rmfield(GLMFlags,'Vi');

Anz = numel(GLMFlags.sub);

% fils = dir(fullfile(mask_path,mask_str)); 
% fils = fils([5:end 1:4]); 
% fils = {fils.name}; 

fils{1} = fullfile(glob_mask_path,glob_mask_str)

clear msk ROI VM XYZ

for i=1:numel(fils)
    VM(i) = spm_vol(fullfile(fils{i}));
    msk(:,:,:,i) = round(spm_read_vols(VM(i)));
end

% add global mask for voxel-wise data
% VM(numel(fils)+1) = spm_vol(fullfile(glob_mask_path,glob_mask_str));
% msk(:,:,:,numel(fils)+1) = round(spm_read_vols(VM(numel(fils)+1)));

ind = find(sum(msk>0,4)>0); 
[XYZ(:,1), XYZ(:,2), XYZ(:,3)] = ind2sub(VM(1).dim,ind); 
XYZ = XYZ';

% for i=1:numel(fils)
%     mask = msk(:,:,:,i);
%     ROI(i,:) = mask(ind);
%     GLMFlags.dat{i} = single(nan(Anz,max(ROI(i,:))));
% end

% global mask
mask = msk(:,:,:,1);
global_mask = mask(ind);
GLMFlags.dat{numel(fils)} = single(nan(Anz,length(find(global_mask>0))));


XYZmm = VM(1).mat * [XYZ; ones(1,size(XYZ,2))]; 
timer = nan(1,numel(GLMFlags.sub)); 

% for i=1:Anz
%     tic
%     XYZ = inv(Vi(i).mat) * XYZmm;
%     tmp = spm_sample_vol(Vi(i),XYZ(1,:),XYZ(2,:),XYZ(3,:),1);
%     
%     for ii=1:numel(fils)
%         tmx = zeros(1,max(ROI(ii,:)));
%         roi = ROI(ii,:);
%         parfor ana = 1:max(ROI(ii,:))
%             tmx(ana) = trimmean(tmp(roi==ana),10);
%         end
%         GLMFlags.dat{ii}(i,:) = tmx;
%     end
%     
%     timer(i) = toc;
%     fprintf(1,'%s\n',[int2str(i) ': ' num2str(timer(i),'%2.1f') 's -> ' int2str((Anz-i)*nanmean(timer)/3660) 'h left'])
% end

% global mask

for i=1:Anz
    tic
    XYZ = inv(Vi(i).mat) * XYZmm;
    tmp = spm_sample_vol(Vi(i),XYZ(1,:),XYZ(2,:),XYZ(3,:),1);
    tmx = tmp(global_mask>0);
    GLMFlags.dat{numel(fils)}(i,:) = tmx;
    timer(i) = toc;
    fprintf(1,'%s\n',[int2str(i) ': ' num2str(timer(i),'%2.1f') 's -> ' int2str((Anz-i)*nanmean(timer)/3660) 'h left'])
end



for i=1:Anz
    tic
    XYZ = inv(Vi(i).mat) * XYZmm;
    GLMFlags.scale(i) = sum(spm_sample_vol(Vi(i),XYZ(1,:),XYZ(2,:),XYZ(3,:),1));
end

save(fullfile(savedir, [outf,'raw.mat']),'GLMFlags','-v7.3')
%save([savedir,outf,'raw.mat'],'GLMFlags','-v7.3')
