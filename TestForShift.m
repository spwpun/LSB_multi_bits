clear;
fprintf('Now it`s embedding time......\n')
prompt = 'Please input the cover image name: ';
cover_name = input(prompt,'s');
prompt = 'Please input the secret image name: ';
secret_name = input(prompt,'s');
prompt = 'Please input the secret key: ';
key_embed = input(prompt);
shift_embed(cover_name, secret_name, key_embed);
fprintf('Embed Success!\n\n\n');
fprintf('Now it`s extracting time......\n');
prompt = 'Please input the stegano image name:';
steg_name = input(prompt,'s');
prompt = 'Please input the secret key: ';
key_extract = input(prompt);
shift_extract(steg_name, key_extract);
fprintf('Extract completed!\n');
fprintf('End!\n');