%% synthetic_latdep_B

clear

% set up x array (latitude)
jmx = 100; % size of D grid
delx = 2.0/jmx;
xD = (-1:delx:1)';
phiD = asind(xD);

D_default = 1.29

%% D enhancement in mid-latitudes (storm track band)

phic = 45;
sigmax = 0.08;
pfac = 1;
Dmlb_cgm = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 1, 0);
[Dmlb,rmlb] = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 0, 0);

%% D enhancement in high-latitudes (storm track band)

phic = 60;
sigmax = 0.08;
pfac = 1;
Dhlb_cgm = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 1, 0);
[Dhlb,rhlb] = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 0, 0);

%% D enhancement in low-latitudes

phic = 15;
sigmax = 0.08;
pfac = 1;
Dllb_cgm = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 1, 0);
[Dllb,rllb] = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 0, 0);

%% D decrease in low-latitudes

phic = 15;
sigmax = 0.08;
pfac = -1; % subtract 2*(3/8)*D_default at the trough
Dllv_cgm = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 1, 0);
[Dllv,rllv] = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 0, 0);

%% D decrease in mid-latitudes

phic = 45;
sigmax = 0.08;
pfac = -1; % subtract 2*(3/8)*D_default at the trough
Dmlv_cgm = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 1, 0);
[Dmlv,rmlv] = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 0, 0);

%% D decrease in high-latitudes

phic = 60;
sigmax = 0.08;
pfac = -1; % subtract 2*(3/8)*D_default at the trough
Dhlv_cgm = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 1, 0);
[Dhlv,rhlv] = get_latdep_D(phiD, phic, sigmax, pfac, D_default, 0, 0);

%% Visualization

Dconst = D_default*ones(size(xD));
xt = [-1 -sqrt(3)/2 -1/2 0 1/2 sqrt(3)/2 1];
xtl = ['-90'; '-60'; '-30'; '  0'; ' 30'; ' 60'; ' 90'];

figure('position',[0 0 500 700]);
subplot(3,1,1)
plot(xD,Dmlb_cgm,'linewidth',2.2)
hold on; grid on
plot(xD,Dmlb,'linewidth',2.2)
plot(xD,Dconst,':','color','#0072BD')
plot(xD,Dconst*rmlb,':','color','#D95319')
ylim([0, 1.85])
xticks(xt)
set(gca,'Xticklabel',[])

subplot(3,1,2)
plot(xD,Dllb_cgm,'linewidth',2.2)
hold on; grid on
plot(xD,Dllb,'linewidth',2.2)
plot(xD,Dconst,':','color','#0072BD')
plot(xD,Dconst*rllb,':','color','#D95319')
ylim([0, 1.85])
xticks(xt)
set(gca,'Xticklabel',[])

subplot(3,1,3)
plot(xD,Dllv_cgm,'linewidth',2.2)
hold on; grid on
plot(xD,Dllv,'linewidth',2.2)
plot(xD,Dconst,':','color','#0072BD')
plot(xD,Dconst*rllv,':','color','#D95319')
ylim([0, 1.85])
xlim([-1, 1])
xlabel('Latitude','fontsize',18)
xticks(xt); xticklabels(xtl)
legend('bumped D (global mean conserved)',...
       'bumped D (global mean increased)',...
       'constant D (global mean as default)',...
       'constant D (global mean increased)', 'location','best')


%% Save data

mebm_dir = 'C:/Users/Administration/Downloads/';
r = rmlb;
note = {'phi: latitude in degree', 'const: constant',...
        'mlb: mid-latitude bump', 'llb: low-latitude bump',...
        'llv: low-latitude valley', 'cgm: conserve global mean',...
        ['r: ratio of global mean diffusivity (non-cgm) relative',...
         ' to the default']}';
save([mebm_dir,'synthetic_latdep_B.mat'],...
     'phiD','Dconst','Dmlb_cgm','Dmlb','rmlb','Dhlb','Dhlb_cgm','rhlb',...
     'Dllb_cgm','Dllb','rllb','Dllv_cgm','Dllv','rllv','Dmlv','rmlv','Dmlv_cgm','Dhlv','rhlv','Dhlv_cgm','note')
