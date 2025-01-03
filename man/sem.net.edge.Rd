% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/networkFun_edge.R
\name{sem.net.edge}
\alias{sem.net.edge}
\title{Fit a sem model with network data using edges as variables. User-specified network statistics will be calculated and used as variables instead of the networks themselves in the SEM.}
\usage{
sem.net.edge(
  model = NULL,
  data = NULL,
  type = "difference",
  ordered = NULL,
  sampling.weights = NULL,
  data.rescale = FALSE,
  group = NULL,
  cluster = NULL,
  netstats.rescale = FALSE,
  constraints = "",
  WLS.V = NULL,
  NACOV = NULL,
  ...
)
}
\arguments{
\item{model}{a model specified in lavaan model syntax.}

\item{data}{a list containing both the non-network and network data}

\item{type}{"difference" for using the difference between the network statistics of the two actors as the edge covariate; "average" for using the average of the network statistics of the two actors as the edge covariate}

\item{ordered}{parameter same as "ordered" in the lavaan sem() function; whether to treat data as ordinal}

\item{sampling.weights}{parameter same as "sampling.weights" in the lavaan sem() function; whether to apply weights to data}

\item{data.rescale}{whether to rescale the whole dataset (with restructured network and nonnetwork data) to have mean 0 and standard deviation 1 when fitting it to SEM, default to FALSE}

\item{group}{parameter same as "group" in the lavaan sem() function; whether to fit a multigroup model}

\item{cluster}{parameter same as "cluster" in the lavaan sem() function; whether to fit a cluster model}

\item{netstats.rescale}{a logical value indicating whether to rescale network statistics or variables to have mean 0 and sd 1}

\item{constraints}{parameter same as "constraints" in the lavaan sem() function; whether to apply constraints to the model}

\item{WLS.V}{parameter same as "WLS.V" in the lavaan sem() function; whether to use WLS.V estimator}

\item{NACOV}{parameter same as "NACOV" in the lavaan sem() function; whether to use NACOV estimator}

\item{...}{optional arguments for the sem() function}
}
\value{
the updated model specification and a lavaan object which is the SEM results, and the data generated
}
\description{
Fit a sem model with network data using edges as variables. User-specified network statistics will be calculated and used as variables instead of the networks themselves in the SEM.
}
\examples{
\dontrun{
\donttest{
set.seed(100)
nsamp = 20
net <- data.frame(ifelse(matrix(rnorm(nsamp^2), nsamp, nsamp) > 1, 1, 0))
mean(net) # density of simulated network
lv1 <- rnorm(nsamp)
lv2 <- rnorm(nsamp)
nonnet <- data.frame(x1 = lv1*0.5 + rnorm(nsamp),
                     x2 = lv1*0.8 + rnorm(nsamp),
                     x3 = lv2*0.5 + rnorm(nsamp),
                     x4 = lv2*0.8 + rnorm(nsamp))

model <-'
  lv1 =~ x1 + x2
  lv2 =~ x3 + x4
  lv1 ~ net
  lv2 ~ lv1
'
data = list(network = list(net = net), nonnetwork = nonnet)
set.seed(100)
res <- sem.net.edge(model = model, data = data, type = 'difference')
summary(res)
}}
}
