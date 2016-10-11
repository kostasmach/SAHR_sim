function des_angle = td_angle_controller(h_des, xdot_des, ...
                dt_stance, y_lo, y_dot_lo)

% Calculates the touch down angle

global mb Lspring g

k_virtual = mb*(pi/dt_stance)^2;
A = k_virtual*Lspring/(k_virtual - mb * xdot_des^2/Lspring^2);
a = sqrt(k_virtual/mb); 
yapex = y_lo + y_dot_lo^2/(2*g);
m1 = -a*sin(a*dt_stance);
m2 = a*cos(a*dt_stance);
m3 = -A*xdot_des*sin(xdot_des*dt_stance/Lspring)/Lspring;
m4 = A*xdot_des*cos(xdot_des*dt_stance/Lspring)/Lspring;
n1 = sqrt(2*g*(h_des-Lspring))+g*Lspring/(sqrt(2*g*(h_des-Lspring)));
n2 = -g*Lspring/sqrt(2*g*(h_des-Lspring)); 
n3 = n2*cos(xdot_des*dt_stance/Lspring);
n4 = n2*sin(xdot_des*dt_stance/Lspring);
n5 = -sqrt(2*g*(yapex-Lspring))-g*Lspring/sqrt(2*g*(yapex-Lspring));
n6 = g*Lspring/sqrt(2*g*(yapex-Lspring));
m5 = (Lspring-A)*m1+m3-n3+m2*n6/a; 
m6 = A*xdot_des*m2/(Lspring*a) + m4 - n4;
m7 = n1 - m2*n5/a - m1*mb*g/k_virtual; 
R1 = sqrt(m5^2+m6^2);
theta1 = atan2(m6,m5);
theta2 = -acos(m7/R1);

des_angle = theta1 + theta2;

end

