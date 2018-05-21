function rpy = cvtRot2RPY(R)
    al = atan2(R(2,1),R(1,1)); %yaw
    be = atan2(-R(3,1),sqrt(R(3,2)^2 + R(3,3)^2)); %pitch
    gr = atan2(R(3,2),R(3,3)); %row

    rpy = [gr be al];  %row pitch yaw
end