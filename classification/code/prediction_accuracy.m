function acc = prediction_accuracy(Ypred, Yvalid)
    num = size(Ypred,1);
    acc = sum(Ypred == Yvalid) / num;
end

