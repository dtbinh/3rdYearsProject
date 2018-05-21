function T = invtTrans(Mat)
    R = Mat(1:3,1:3);
    d = Mat(1:3,4);
    T = [R.' -R.'*d ; zeros(1,3) 1];
end