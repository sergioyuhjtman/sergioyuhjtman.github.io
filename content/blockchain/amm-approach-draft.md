+++
date = '2026-04-01T12:00:00-00:00'
title = 'A simple but powerful approach to the quantitative study of AMMs'
draft = true
+++

# A simple but powerful approach to the quantitative study of AMMs 

<br>

*Abstract: We explain how to measure income from organic flow in an Automated Market Maker (AMM) and present some results, focusing on a particular pool. We argue for the relevance of this metric and take the opportunity to discuss related concepts.*
<br>

## Introduction

Ultimately, this informal note is about Decentralized Exchange (DEX). In an ideal world, a human should be able to exchange money almost instantly without intermediaries, other than a blockchain that charges gas costs and a tiny swap fee (say, 0.01%). Of course, this DEX utopia wouldn't solve famines, poverty or wars, but it is a significant economic problem that we can tackle and perhaps even solve. The content here serves as a reminder that we have made substantial progress toward this goal.

By analyzing an emblematic pool, we see that the original purpose of the simplest type of AMM has been fulfilled: the incentives for providing liquidity work as intended. We do not aim to provide comprehensive evidence for this claim in general. On the contrary, for the sake of concreteness and simplicity, we focus on [Uniswap V2's USDC/ETH pool](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc), a constant product AMM with a swap fee of 0.3%.

The goal is to illustrate several important points that deserve to be better known and understood across the broader blockchain community. Most notably, a method for analyzing past performance and estimating the future of the Liquidity Provider (LP) position. Even amid the usual chaos of the crypto market, we find some strikingly predictable quantities.

## Pool long-term performance

Let us first examine the evolution of the value (measured in USD) of the LP position between January 2021 and January 2026, [five years](https://www.youtube.com/watch?v=2ObjtVdsV3I). We compare this with the value of simply holding the initial amounts of USDC and ETH. At the beginning of the period, the price of this pair was approximately 750 USDC/ETH, while at the end it reached 3000 USDC/ETH, a fourfold increase. For each initial dollar, the Hold position ends at 2.5 USD, while the LP position ends at 4.25 USD.
The following chart shows the full evolution of the price, the positions' values, and the value of the LP position relative to the Hold position.

<p align="center"> <img src="/images/meth-chart-a.png" alt="LP vs Hold" width="2000"> </p>

Let us break this down. 
A constant product AMM between two tokens always holds half of its value in each pool component. It is not truly "constant product" since the product of the reserves increases after each swap, due to the "swap fee". The performance of the LP position relative to Hold can be decomposed into two components: one that depends deterministically on the current price, and another arising from collected fees. The former always implies a loss (_divergence loss_), while the latter generates gains. The overall performance is therefore the result of this tension. 

In the chart, we can observe that for this pool and time period, there is a clear trend: the orange line consistently outperforms the blue line. The LP position ends up 70% above Hold, corresponding to an annualized return of 11%.

## Betting on predictable noise

As with most live AMMs, in this case it is very useful to disaggregate the trading dynamics into _arbitrage flow_ and _organic flow_. It is impractical —or even impossible— to classify 
individual transactions into one category or the other. Fortunately, there is a relatively simple method to achieve this disaggregation. For a given price sequence, we define the pure arbitrage dynamics as the evolution the pool would experience in the sole presence of an ideal arbitrageur. This dynamic can be simulated retrospectively for the pool under consideration. Any additional flow observed beyond this baseline is, by definition, _organic flow_.

We used this method at Balancer during 2025 to study the evolution of [ReClamm-type](https://docs.balancer.fi/concepts/explore-available-balancer-pools/reclamm-pool/reclamm-pool.html) pools. The simulation approach is standard practice in the field. Its output depends on the ratio *gas_price / liquidity*. However, since the pool is highly liquid in our case, gas costs are effectively diluted, and any reasonable estimate yields approximately the same result. 
Below, we present a chart with the results of the simulation for 2025, along with a comparison to the Hold position and the actual LP position. We also include a simulated feeless pool, which we use as the baseline for the relative value chart. Note that the feeless pool position depends only on the instantaneous price.

<p align="center"> <img src="/images/meth-chart-b.png" alt="Simulation" width="2000"> </p>

The steady pace of the green and red lines is quite remarkable! 

It means that, for this pool, we can credibly estimate the income rates from both arbitrage and organic flow simply by looking at the recent past. These have contributed approximately 5% and 6%, respectively, to the LP position's appreciation. From experience, this pattern of steady growth is not an exception but the norm in AMMs. Of course, not every pool exhibits this level of organic flow, and in many cases price divergence hits hard. In this case, we see how much the typical noise in a cryptocurrency price signal benefits the LP, along with the so-called _noise traders_ responsible for the organic flow.

An economic agent with a model for the final price (e.g., a probability distribution) over a given time horizon can leverage this methodology to obtain a good estimate for the LP position.

Income from arbitrage flow is directly related to volatility. Therefore, roughly speaking, the higher the rate, the greater the risk from price divergence. By contrast, income from organic flow represents pure gain. For this reason, it is a metric that deserves wider attention. More generally, I believe that this simple perspective and methodology can make AMM liquidity provision more transparent to a broader audience, and hopefully attract more participants to the DEX ecosystem.

## The choice of a baseline

The correct benchmark to compare the performance of an LP position is largely dependent on the observer's motivations. The above choice of Hold as a benchmark is motivated by the following properties shared by both positions:

(a) Starts with equal amounts of each token. <br>
(b) Non-custodial. <br>
(c) Passive. <br>

This is why in many cases, Hold is the natural choice: given identical qualitative conditions, the decision making reduces to comparing utilities. In some cases, a user may want to compare the LP position versus lending and/or staking. This does not require a modification, since it could be easily derived once the comparison to Hold is given. There are cases where users may prioritize the sheer provision of liquidity to the market over their position's performance, but that is a totally separate issue.

The influential work [Automated Market Making and Loss-Versus-Rebalancing](https://arxiv.org/pdf/2208.06046) proposes the *rebalancing* strategy as a standard benchmark. The *rebalancing* strategy is defined as "a trading strategy which holds whatever amount of the
risky asset the AMM holds at any point in time, but adjusts its positions in the risky asset by
trading at CEX prices, rather than AMM prices". A similar, more symmetrical choice would be to always have the total value divided in halves. Assuming certain market conditions, it is possible to approximate this strategy in practice. However, there is no known way to achieve it while also having both properties (b) and (c) above. As a consequence, it entails some risks and costs that places it on a different footing than Hold and LP. In this way, for many agents it will ultimately not be the most relevant benchmark.

For the sake of completeness, we include a chart...
Profit versus rebalance.

non-LVR AMMs?  
"This is because in a competitive market for liquidity provision, there should
be no excess profits for LPs, and hence fees should balance with LVR"


## References
- [Willetts, Harrington — "Rebalancing-versus-Rebalancing: Improving the fidelity of
Loss-versus-Rebalancing"](https://cdn.prod.website-files.com/6616670ddddc931f1dd3aa73/672283811331fc9bef39be23_RVR_30_10_24.pdf)
- [Adams, Zinsmeister, Robinson — "Uniswap v2 Core"](https://uniswap.org/whitepaper.pdf)
- [Milionis, Moallemi, Roughgarden, Zhang — "Automated Market Making and Loss-Versus-Rebalancing"](https://arxiv.org/pdf/2208.06046)
- [Yuhjtman — "Affiliated AMMs and permissionless solving for uniform price batch auctions"](https://ethresear.ch/t/affiliated-amms-and-permissionless-solving-for-uniform-price-batch-auctions/20187)
- [Fritsch, Canidio — "Measuring Arbitrage Losses and Profitability of AMM Liquidity"](https://arxiv.org/abs/2404.05803)
- [Nezlobin, Nezlobina, Zinoviev — "Toxic Order Flow on Decentralized Exchanges: Problem and Solutions"](https://medium.com/@alexnezlobin/toxic-order-flow-on-decentralized-exchanges-problem-and-solutions-a1b79f32225a)
- [Uniswap V2 USDC/ETH pool (Etherscan)](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc)
- [Balancer ReClamm pool docs](https://docs.balancer.fi/concepts/explore-available-balancer-pools/reclamm-pool/reclamm-pool.html)


## Acknowledgements
I am deeply grateful to [Balancer](https://balancer.fi/), where I grew professionally over three years.


