b=imread('image_test.bmp'); % 24-bit BMP image RGB888 

col = 640;
lin = 480;
mem_depth = 1048576;    %The size of memory in words
mem_width = 16;         %The size of data in bits

address = (lin*col*24)/mem_width;

if (address > mem_depth)
    disp('Error: Not enough memory!');disp(' ');

else
    
    k=1;
    for i=lin:-1:1
        for j=1:col
            a(k)=b(i,j,1);
            a(k+1)=b(i,j,2);
            a(k+2)=b(i,j,3);
            k=k+3;
        end
    end
    
    fid = fopen('image_test.hex', 'wt');
    
    fprintf(fid, '%02X', a);
    
    disp('Text file write done');disp(' ');
    fclose(fid);
end
