%the MTP of the HMM, A
trans = [0.95,0.05;
          0.10,0.90];
 %the emission probabilites, B
 emis = [1/6 1/6 1/6 1/6 1/6 1/6;
    1/10 1/10 1/10 1/10 1/10 1/2];

%generate a random sequence (seq) of emission symbols, a random sequence
%(states) of states 

[seq,states] = hmmgenerate(100,trans,emis)

%calculate the state probabilities, PSTATS, of the sequence seq
pStates = hmmdecode(seq,trans,emis);

[seq,states] = hmmgenerate(100,trans,emis,...
    'Symbols',{'one','two','three','four','five','six'},...
    'Statenames',{'fair';'loaded'})

%specifies the symbols that are emitted 
pStates = hmmdecode(seq,trans,emis,...
   'Symbols',{'one','two','three','four','five','six'});

%training - uses HMMtrain() on two randomly generated sequences of length
%100 and length 200 sequences 
%hmmtrain(...,'Algorithm',algorithm) specifies the training algorithm; algorithm can be either 'BaumWelch' or 'Viterbi'.

seq1 = hmmgenerate(100,trans,emis);
seq2 = hmmgenerate(200,trans,emis);
seqs = {seq1,seq2};
[estTR,estE] = hmmtrain(seqs,trans,emis);
