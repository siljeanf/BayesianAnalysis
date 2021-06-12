data {
  int n;
  real mu_a;
  real mu_beta;
  real mu_gamma;
  real mu_sigma;
  vector[n] y;
}

parameters {
  real alpha;
  real gamma;
  real<lower = 0> sigma;
  real<lower =0> beta;
}

model {
  //update initial values for the mean 
  for (i in 1:7){
     y[i] ~ normal(y[i], sigma);
  }
  
  for (i in 8:n){
    y[i] ~ normal(alpha + beta*y[i-1] + gamma*y[i-7] , sigma);
}
  
  alpha ~ normal(mu_a,1);
  beta~ normal(mu_beta,10);
  gamma~normal(mu_gamma,10);
  sigma~normal(mu_sigma,10);
}

generated quantities{
  vector[7] y_pred;
  y_pred[1] = alpha + beta*y[n] + gamma*y[n-6];
  y_pred[2] = alpha + beta*y_pred[1] + gamma*y[n-5];
  y_pred[3] = alpha + beta*y_pred[2] + gamma*y[n-4];
  y_pred[4] = alpha + beta*y_pred[3] + gamma*y[n-3];
  y_pred[5] = alpha + beta*y_pred[4] + gamma*y[n-2];
  y_pred[6] = alpha + beta*y_pred[5] + gamma*y[n-1];
  y_pred[7] = alpha + beta*y_pred[6] + gamma*y[n];
}
