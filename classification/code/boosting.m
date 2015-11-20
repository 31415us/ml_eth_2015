function pred = boosting(X,Y,T)
    E = fitensemble(X,Y,'AdaBoostM2', 100, 'Tree'); 
    pred = predict(E, T);
end

