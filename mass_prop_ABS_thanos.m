%%% ABS Mass Properties, Thanos Version
m_temp = 0.4; % Kg
m1_ABS = m_temp;
m2_ABS = m_temp;
m3_ABS = m_temp;



m_mat = diag([m1 m2 m3]);
m_tot_bal = sum(m_mat, 'all');