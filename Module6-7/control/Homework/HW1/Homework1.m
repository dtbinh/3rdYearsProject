%Sorrawit Inprom, 15/08/2017, This is function that computes an
%approximation of the definite integral of a given function.
function integration = Homework1(f,a,b,n)
    Area = 0;
    increment = (b-a)/n;
    End = b-((b-a)/n);
    for x = a : increment : End
        Area = 0.5*(b-a)/n*(f(x+((b-a)/n))+f(x));
    end
    integration = Area;
end