

%% Plot of Command vs Feedback
figure
subplot(3,1,1)
plot(out.PositionCmdFdbk.time,out.PositionCmdFdbk.signals.values(:,1),'LineWidth',2)
hold on
plot(out.PositionCmdFdbk.time,out.PositionCmdFdbk.signals.values(:,4),'LineWidth',2)
hold off
grid
ylabel('X Position')
legend('Baseline','Autotuned')
title('Command vs Feedback')

subplot(3,1,2)
plot(out.PositionCmdFdbk.time,out.PositionCmdFdbk.signals.values(:,2),'LineWidth',2)
hold on
plot(out.PositionCmdFdbk.time,out.PositionCmdFdbk.signals.values(:,5),'LineWidth',2)
hold off
grid
ylabel('Y Position')

subplot(3,1,3)
plot(out.PositionCmdFdbk.time,out.PositionCmdFdbk.signals.values(:,3),'LineWidth',2)
hold on
plot(out.PositionCmdFdbk.time,out.PositionCmdFdbk.signals.values(:,6),'LineWidth',2)
hold off
grid
xlabel('Time (sec)')
ylabel('Z Position')

