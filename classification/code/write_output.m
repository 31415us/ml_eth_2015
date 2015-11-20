function write_output(out_path, indices, predY)
    output = [indices, uint32(predY)];

    fid = fopen(out_path, 'w');
    fprintf(fid,'Id,Label\n');
    fclose(fid);
    format long
    dlmwrite(out_path, output, '-append');
end
