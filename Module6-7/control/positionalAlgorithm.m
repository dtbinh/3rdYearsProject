function [t_v,y_v,u_v] = positionalAlgorithm
r = 1;
t_max = 10;
sat = 1000000;
global u;
global y;
global d;
global p_y;
p_y = 0;

t_v = [];
y_v = [];
u_v = [];
u = 0;
d = 0;

h = 0.01;
t_dynamics_loop = timer('StartDelay', 0, 'Period', h,'ExecutionMode', 'fixedRate');
t_dynamics_loop.TimerFcn = {@rungeKutta4, h};
t_dynamics_loop.StartFcn = @initializeRK4;

Ts = 0.05;
t_controller_loop = timer('StartDelay', 0.5, 'Period', Ts,'ExecutionMode', 'fixedRate');
t_controller_loop.TimerFcn = {@controller, Ts};
t_controller_loop.StartFcn = @initializePID;


start(t_dynamics_loop)
start(t_controller_loop)


while toc<t_max
    if toc>5
        r = -1;
    end
end

stop(t_dynamics_loop)
stop(t_controller_loop)
delete(timerfind)

    function controller(src,event,h)
        
        data = src.UserData;
        y_read = y;
        e = r-y_read;
        int_e = e+data.int_e; % s[k]
        d_e = e-data.pre_e;
        
        K_P = 6;
        K_I = 0.05;
        K_D = 25;
        
        u = K_P*e + K_I*int_e + K_D*d_e;
        data = struct('int_e', int_e, 'pre_e', e);
        src.UserData = data;
        p_y = y_read;
    end

    function rungeKutta4(src,event,h)
        t = toc;
        data = src.UserData;
        x = data.x;
        i = data.i;
        
        k_1 = dynamics(t,x,u);
        k_2 = dynamics(t+h/2,x+k_1*h/2,u);
        k_3 = dynamics(t+h/2,x+k_2*h/2,u);
        k_4 = dynamics(t+h,x+k_3*h,u);
        data = struct('x',x+(k_1+2*k_2+2*k_3+k_4)*h/6 , 'i', i);
        y = x(1);
        y_v(end+1) = y;
        t_v(end+1) = t;
        u_v(end+1) = max(min(u,sat),-sat);
        src.UserData = data;
        
        n = 10; % divider : how often plotting
        if i >=n
            data.i = 0;
            src.UserData = data;
            
            subplot(2,1,1)
            plot([t_v(end-n) t_v(end)],[y_v(end-n) y_v(end)],'m');
            subplot(2,1,2)
            plot([t_v(end-n) t_v(end)],[u_v(end-n) u_v(end)],'b');
            drawnow;
            %             disp(y);
        else
            data.i = i+1;
            src.UserData = data;
        end
    end

    function initializeRK4(src,event)
        tic;
        x_0 = [0;0];
        src.UserData = struct('x', x_0, 'i', 0);
        disp('Initialized');
        figure(1)
        subplot(2,1,1)
        hold on;
        axis([0 t_max -2*r 2*r]);
        grid on;
        plot([0 t_max],[r r],'r--')
        plot([0 t_max],[0 0],'k')
        y_v(end+1) = x_0(1);
        t_v(end+1) = toc;
        subplot(2,1,2)
        hold on;
        axis([0 t_max -10 10]);
        grid on;
        plot([0 t_max],[0 0],'k')
    end

    function initializePID(src,event)
        src.UserData = struct('int_e', 0, 'pre_e', 0);
        disp('PID_Initialized');
    end

    function f = dynamics(t,x,u)
        f = [x(2);-x(2)+max(min(u(1),sat),-sat)+d];
    end

end
