clear all
Fs1 = 8000; %Set Sampling Frequency
Fr = Fs1; %Set Reconstruction Frequency
Fs = Fs1; % The multiple of the sampling frequency to be used
T = 1/Fs; %Sampling Period
bpm = 120; %beats per minute
temp = 1/(bpm/60); %tempo
N = temp*Fs1; %Number of samples to achieve desired duration
M = 1; % M is the number of ticks of a note, initial value is 1
n = @(M) 1:M*N; %the array, n, takes an integer multiplier, M, that can reduce or increase the duration %% Define the notes
%Frequencies of notes
F_C4=261.6;
F_D4 =293.7;
F_E4=329.6;
F_F4=349.2;
F_Fs4=369.99;
F_G4=392;
F_Gs4=415.3;
F_A4=440; %Frequency of note A is 440 Hz
F_B4=493.88;
F_Bb4=466.2;
F_C5=523.25;
F_Cs5=554.37;
F_D5=587.33;
F_Ds5=622.25;
F_E5=659.26;
F_F5=698.46;
F_Fs5=739.99;
% Make notes
C4= @(M) sin(2*pi*F_C4*T*n(M));
D4= @(M) sin(2*pi*F_D4*T*n(M));
E4= @(M) sin(2*pi*F_E4*T*n(M));
F4= @(M) sin(2*pi*F_F4*T*n(M));
Fs4= @(M) sin(2*pi*F_Fs4*T*n(M));
G4= @(M) sin(2*pi*F_G4*T*n(M));
Gs4= @(M) sin(2*pi*F_Gs4*T*n(M));
A4= @(M) sin(2*pi*F_A4*T*n(M));
B4= @(M) sin(2*pi*F_B4*T*n(M));
C5= @(M) sin(2*pi*F_C5*T*n(M));
Cs5= @(M) sin(2*pi*F_Cs5*T*n(M));
D5= @(M) sin(2*pi*F_D5*T*n(M));
13
Capstone B FINAL VERSION
Ds5= @(M) sin(2*pi*F_Ds5*T*n(M));
E5= @(M) sin(2*pi*F_E5*T*n(M));
F5= @(M) sin(2*pi*F_F5*T*n(M));
Fs5= @(M) sin(2*pi*F_Fs5*T*n(M));
%Define Rests
sr = zeros(1, .05*N); %short rest between any two consequtive notes
sixtr = zeros(1, .0625*N); %sixteenth rest
er = zeros(1, .125*N); % eigth rest
qr = zeros(1, .25*N); % quarter rest
hr = zeros(1, .5*N); % half rest
tr = zeros(1, .75*N); % three-quarter rest
wr = zeros(1, N); % whole rest
% Define chords
D = [D4(M) Fs4(M) A4(M)];
G = [G4(M) B4(M) D5(M)];
B = [B4(M) Ds5(M) Fs5(M)];
Em = [E4(M) G4(M) B4(M)];
A = [A4(M) Cs5(M) E5(M)];
%% Original piece
bar1 = [B4(1) sr B4(1) sr C5(1) sr D5(1) sr];
bar2 = [D5(1) sr C5(1) sr B4(1) sr A4(1) sr];
bar3 = [G4(1) sr G4(1) sr A4(1) sr B4(1) sr];
bar4 = [B4(1.5) sr A4(0.5) sr A4(2) sr];
bar5 = [B4(1) sr B4(1) sr C5(1) sr D5(1) sr];
bar6 = [D5(1) sr C5(1) sr B4(1) sr A4(1) sr];
bar7 = [G4(1) sr G4(1) sr A4(1) sr B4(1) sr];
bar8 = [A4(1.5) sr G4(0.5) sr G4(2) sr];
bar9 = [A4(1) sr A4(1) sr B4(1) sr G4(1) sr];
bar10 = [A4(1) sr B4(0.5) sr C5(0.5) sr B4(1) sr G4(1) sr];
bar11 = [A4(1) sr B4(0.5) sr C5(0.5) sr B4(1) sr A4(1) sr];
bar12 = [G4(1) sr A4(1) sr D4(1) sr B4(1) sr];
bar13 = [B4(1) sr B4(1) sr C5(1) sr D5(1) sr];
bar14 = [D5(1) sr C5(1) sr B4(1) sr A4(1) sr];
bar15 = [G4(1) sr G4(1) sr A4(1) sr B4(1) sr];
bar16 = [A4(1.5) sr G4(0.5) sr G4(2)];
% Make original version
original = [bar1, bar2, bar3, bar4, bar5, bar6, bar7, bar8, bar9, bar10, bar11, bar12, bar13, bar14, %sound(original,Fs); %--- Remove %-sign to hear the original version%
%wavwrite(original,'original.wav'); %--- Remove %-sign to make .wav file of
% of the original version%
%% Improvisation
chords = ['D '; 'G '; 'D '; 'G '; 'D '; 'B '; 'Em'; 'A '; 'D '; 'D '];
14
Capstone B FINAL VERSION
%% Start improv
improv = [];
firstdur = [0.2 0.3 0.2 0.3]; %Vector defining probabilities to go to a sixteenth note; eigth note; r0 = rand;
if r0 < firstdur(1,1);
L = 0.25;
elseif r0 < firstdur(1,1) + firstdur(1,2);
L = 0.5;
elseif r0 < firstdur(1,1) + firstdur(1,2) + firstdur(1,3);
L = 0.75;
else L = 1;
end
for k = 1:6
current_chord = chords(k,:);
ticks = 0;
while ticks < 2 %There can only by 4 'ticks' in a bar, 1 tick equals a quarternote
% duration
tmdur = [0 0 1/2 1/2;0 5/20 0 15/20;0 1/3 1/3 1/3;0 8/20 0 12/20];
% create the vector that will be multiplied with the transition matrix,
% such that only the row of the current note will be left
multiplier1 = zeros(1,4);
if L == 0.25;
multiplier1(1,1) = 1;
elseif L == 0.5;
multiplier1(1,2) = 1;
elseif L == 0.75;
multiplier1(1,3) = 1;
elseif L == 1;
multiplier1(1,4) = 1;
end
durvector = multiplier1*tmdur;
% decide which duration will come next, by making sure a random variable r
% will fall within the probabilities, but also by making sure the number
% of ticks inside a bar cannot exceed 2 (with 0.5 as a last resort)
r1 = rand;
if r1 < durvector(1,1);
new_dur = 0.25;
elseif r1 < (durvector(1,1) + durvector(1,2)) && ticks <= 1.5;
new_dur = 0.5;
elseif r1 < (durvector(1,1) + durvector(1,2) + durvector(1,3)) && ticks <=1.25;
new_dur = 0.75;
15
Capstone B FINAL VERSION
elseif r1 < (durvector(1,1) + durvector(1,2) + durvector(1,3) + durvector(1,4)) && ticks <= 1
new_dur = 1;
else new_dur = 2 - ticks;
end
L = new_dur;
% pitch
multiplier2 = zeros(1,3);
if strcmp(current_chord,'D ');
current_pitch = D4(L);
tmpitch = [4/14 1/14 4/14 1/14 4/14;4/14 1/14 2/14 1/14 6/14;3/14 1/14 3/14 1/14 6/14];
% create the vector that will be multiplied with the transition matrix,
% such that only the row of the current note will be left
if current_pitch == D4(L);
multiplier2(1,1) = 1;
elseif current_pitch == E4(L);
multiplier2(1,2) = 1;
elseif current_pitch == Fs4(L);
multiplier2(1,3) = 1;
elseif current_pitch == G4(L);
multiplier2(1,4) = 1;
elseif current_pitch == A4(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = D4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = E4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = Fs4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = G4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = A4(L);
end
elseif strcmp(current_chord,'G ');
16
Capstone B FINAL VERSION
current_pitch = G4(L);
tmpitch = [4/14 1/14 4/14 1/14 4/14;4/14 1/14 2/14 1/14 6/14;3/14 1/14 3/14 1/14 6/14];
if current_pitch == G4(L);
multiplier2(1,1) = 1;
elseif current_pitch == A4(L);
multiplier2(1,2) = 1;
elseif current_pitch == B4(L);
multiplier2(1,3) = 1;
elseif current_pitch == C5(L);
multiplier2(1,4) = 1;
elseif current_pitch == D5(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = G4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = A4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = B4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = C5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = D5(L);
end
elseif strcmp(current_chord,'B ');
current_pitch = B4(L);
tmpitch = [4/14 1/14 4/14 1/14 4/14;4/14 1/14 2/14 1/14 6/14;3/14 1/14 3/14 1/14 6/14];
if current_pitch == B4(L);
multiplier2(1,1) = 1;
elseif current_pitch == Cs5(L);
multiplier2(1,2) = 1;
elseif current_pitch == Ds5(L);
multiplier2(1,3) = 1;
elseif current_pitch == E5(L);
multiplier2(1,4) = 1;
elseif current_pitch == Fs5(L);
multiplier2(1,5) = 1;
end
17
Capstone B FINAL VERSION
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = B4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = Cs5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = Ds5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = E5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = Fs5(L);
end
elseif strcmp(current_chord,'Em');
current_pitch = E4(L);
tmpitch = [4/14 1/14 4/14 1/14 4/14;4/14 1/14 2/14 1/14 6/14;3/14 1/14 3/14 1/14 6/14];
if current_pitch == E4(L);
multiplier2(1,1) = 1;
elseif current_pitch == Fs4(L);
multiplier2(1,2) = 1;
elseif current_pitch == G4(L);
multiplier2(1,3) = 1;
elseif current_pitch == A4(L);
multiplier2(1,4) = 1;
elseif current_pitch == B4(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = E4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = Fs4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = G4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = A4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
18
Capstone B FINAL VERSION
new_pitch = B4(L);
end
elseif strcmp(current_chord,'A ');
current_pitch = A4(L);
tmpitch = [4/14 1/14 4/14 1/14 4/14;4/14 1/14 2/14 1/14 6/14;3/14 1/14 3/14 1/14 6/14];
if current_pitch == A4(L);
multiplier2(1,1) = 1;
elseif current_pitch == B4(L);
multiplier2(1,2) = 1;
elseif current_pitch == Cs5(L);
multiplier2(1,3) = 1;
elseif current_pitch == D5(L);
multiplier2(1,4) = 1;
elseif current_pitch == E5(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = A4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = B4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = Cs5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = D5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = E5(L);
end
end
%create the improvisation
improv = [improv,new_pitch,sr]; %the new note will be put in a matrix
current_pitch = new_pitch; %the new note will become the next current note
ticks = ticks + L;
end
end
for k = 7:10;
current_chord = chords(k,:);
ticks = 0;
while ticks < 1 %There can only by 4 'ticks' in a bar, 1 tick equals a quarternote
19
Capstone B FINAL VERSION
% duration
tmdur = [0 0 0.75 0.25;0 2/6 0 4/6;0 1/2 0 1/2;0 1/6 0 5/6];
% create the vector that will be multiplied with the transition matrix,
% such that only the row of the current note will be left
multiplier1 = zeros(1,4);
if L == 0.25;
multiplier1(1,1) = 1;
elseif L == 0.5;
multiplier1(1,2) = 1;
elseif L == 0.75;
multiplier1(1,3) = 1;
elseif L == 1;
multiplier1(1,4) = 1;
end
durvector = multiplier1*tmdur;
% decide which duration will come next, by making sure a random variable r
% will fall within the probabilities, but also by making sure the number
% of ticks inside a bar cannot exceed 1
r1 = rand;
if r1 < durvector(1,1);
new_dur = 0.25;
elseif r1 < (durvector(1,1) + durvector(1,2)) && ticks <= 1.5;
new_dur = 0.5;
elseif r1 < (durvector(1,1) + durvector(1,2) + durvector(1,3)) && ticks <=1.25;
new_dur = 0.75;
elseif r1 < (durvector(1,1) + durvector(1,2) + durvector(1,3) + durvector(1,4)) && ticks new_dur = 1;
else new_dur = 1 - ticks;
end
L = new_dur;
% pitch
multiplier2 = zeros(1,3);
if strcmp(current_chord,'D ');
current_pitch = D4(L);
tmpitch = [4/10 1/10 2/10 1/10 2/10;4/10 1/10 2/10 1/10 2/10;4/10 1/10 2/10 1/10 2/10];
% create the vector that will be multiplied with the transition matrix,
% such that only the row of the current note will be left
if current_pitch == D4(L);
20
Capstone B FINAL VERSION
multiplier2(1,1) = 1;
elseif current_pitch == E4(L);
multiplier2(1,2) = 1;
elseif current_pitch == Fs4(L);
multiplier2(1,3) = 1;
elseif current_pitch == G4(L);
multiplier2(1,4) = 1;
elseif current_pitch == A4(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = D4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = E4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = Fs4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = G4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = A4(L);
end
elseif strcmp(current_chord,'G ');
current_pitch = G4(L);
tmpitch = [2/10 1/10 4/10 1/10 2/10;2/10 1/10 4/10 1/10 2/10;2/10 1/10 4/10 1/10 2/10];
if current_pitch == G4(L);
multiplier2(1,1) = 1;
elseif current_pitch == A4(L);
multiplier2(1,2) = 1;
elseif current_pitch == B4(L);
multiplier2(1,3) = 1;
elseif current_pitch == C5(L);
multiplier2(1,4) = 1;
elseif current_pitch == D5(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
21
Capstone B FINAL VERSION
if r2 < notevector(1,1);
new_pitch = G4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = A4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = B4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = C5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = D5(L);
end
elseif strcmp(current_chord,'B ');
current_pitch = B4(L);
tmpitch = [4/10 1/10 2/10 1/10 2/10;4/10 1/10 2/10 1/10 2/10;4/10 1/10 2/10 1/10 2/10];
if current_pitch == B4(L);
multiplier2(1,1) = 1;
elseif current_pitch == Cs5(L);
multiplier2(1,2) = 1;
elseif current_pitch == Ds5(L);
multiplier2(1,3) = 1;
elseif current_pitch == E5(L);
multiplier2(1,4) = 1;
elseif current_pitch == Fs5(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = B4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = Cs5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = Ds5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = E5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = Fs5(L);
end
elseif strcmp(current_chord,'Em');
current_pitch = E4(L);
22
Capstone B FINAL VERSION
tmpitch = [2/10 1/10 4/10 1/10 2/10;2/10 1/10 4/10 1/10 2/10;2/10 1/10 4/10 1/10 2/10];
if current_pitch == E4(L);
multiplier2(1,1) = 1;
elseif current_pitch == Fs4(L);
multiplier2(1,2) = 1;
elseif current_pitch == G4(L);
multiplier2(1,3) = 1;
elseif current_pitch == A4(L);
multiplier2(1,4) = 1;
elseif current_pitch == B4(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = E4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = Fs4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = G4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = A4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = B4(L);
end
elseif strcmp(current_chord,'A ');
current_pitch = A4(L);
tmpitch = [4/10 1/10 2/10 1/10 2/10;4/10 1/10 2/10 1/10 2/10;4/10 1/10 2/10 1/10 2/10];
if current_pitch == A4(L);
multiplier2(1,1) = 1;
elseif current_pitch == B4(L);
multiplier2(1,2) = 1;
elseif current_pitch == Cs5(L);
multiplier2(1,3) = 1;
elseif current_pitch == D5(L);
multiplier2(1,4) = 1;
elseif current_pitch == E5(L);
multiplier2(1,5) = 1;
end
notevector = multiplier2 * tmpitch;
23
Capstone B FINAL VERSION
% Decide which variable will be next
r2 = rand;
if r2 < notevector(1,1);
new_pitch = A4(L);
elseif r2 < (notevector(1,1)+notevector(1,2));
new_pitch = B4(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3));
new_pitch = Cs5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4));
new_pitch = D5(L);
elseif r2 < (notevector(1,1)+notevector(1,2)+notevector(1,3) + notevector(1,4) + notevector(1,5));
new_pitch = E5(L);
end
end
improv = [improv,new_pitch,sr]; %the new note will be put in a matrix
current_pitch = new_pitch; %the new note will become the next current note
ticks = ticks + L;
end
end
originalpart = [bar9 bar10 bar11 bar12];
%sound(originalpart,Fs); % uncomment if you want to hear he original
%version and the improvisation at the same time (does not sound very nice %sound(improv,Fs);
%wavwrite(improv,'improv.wav')
%% Make musical piece with improvisation in one line
sound([bar1 bar2 bar3 bar4 bar5 bar6 bar7 bar8 improv bar13 bar14 bar15 bar16],Fs);
24