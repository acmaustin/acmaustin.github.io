% passwordOut = makeRandomPassword(PWlength)
%
% acma 180103 
%
% generates a random password of length PWlength where the "alphabet"
% consists of upper- and lower-case letters and numbers.
%
% if you trust a random matlab script from the internet to generate your 
% new passwords, then frankly you deserve all that is coming to you... 

function passwordOut = makeRandomPassword(PWlength)

rng('shuffle'); % set the seed to the current time to get "better" randomness

upperAlphabet = char([1:26]+'A'-1);     % hahaha
lowerAlphabet = char([1:26]+'a'-1);
numbersAlphabet = '0123456789';
% add more "alphabets" here... e.g., characters etc

totalAlphabet = [numbersAlphabet,lowerAlphabet,upperAlphabet];

POSSIBLECHARS = length(totalAlphabet);

A = randi(POSSIBLECHARS,PWlength,1);  

passwordOut = totalAlphabet(A);