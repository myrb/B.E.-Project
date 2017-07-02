for k = 1:70
	% Create a mat filename, and load it into a structure called matData.
    %Change the filename according to the folder you're in
	matFileName = sprintf('finger%d.xlsx', k);
  
	if exist(matFileName, 'file')
		data = xlsread(matFileName);
        data = data(:,2);
        
        mn=mean(data);
rn=rms(data);
v=var(data);
sd=std(data);
 ma=max(data);
 T=[mn rn v sd ma];

        xlsappend('finger_feat.xlsx',T);%append each time 
	else
		fprintf('File %s does not exist.\n', matFileName);
    end
end