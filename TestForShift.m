clear;
fprintf('Now it`s embedding time......\n')
prompt = 'Please input the cover image name: ';
cover_name = input(prompt,'s');
prompt = 'Please input the secret image name: ';
secret_name = input(prompt,'s');
shift_embed(cover_name, secret_name);
fprintf('Embed Success!\n\n\n');
fprintf('Now it`s extracting time......\n');
prompt = 'Please input the stegano image name:';
steg_name = input(prompt,'s');
shift_extract(steg_name);
fprintf('End!\n');