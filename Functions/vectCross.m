function a_cross  = vectCross(a_vect)
% Cross Product Operator function returns a^x
a_cross = [   0        -a_vect(3,1) a_vect(2,1);
           a_vect(3,1)       0     -a_vect(1,1);
          -a_vect(2,1)  a_vect(1,1)      0];
end