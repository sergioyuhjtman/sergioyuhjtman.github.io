+++
date = '2026-04-01T12:00:00-00:00'
title = 'An introduction to the quantitative study of AMMs'
draft = false
+++

# An introduction to the quantitative study of AMMs

Sergio A. Yuhjtman - June 2026
<br>

*Abstract: We present, for a general audience, a simple framework for assessing the performance of a liquidity position in an Automated Market Maker (AMM). We explore the effects of arbitrage, organic flow, and rebalancing, and illustrate several commonly observed patterns, using data from a representative pool. In particular, we highlight the approximately linear evolution of a number of key indicators. Finally, we discuss an empirical connection between rebalancing and protocol fees.*
<br>

## Introduction

The main motivation behind this informal note is to contribute to the field of Decentralized Exchange (DEX). In an ideal world, a human should be able to exchange money almost instantly without intermediaries, other than a blockchain that charges gas costs and a very small swap fee. Of course, this DEX utopia wouldn't solve famines, poverty or wars, but it is a significant economic problem that we can tackle and perhaps even solve. The content here serves as a reminder that we have made substantial progress toward this goal. As a related example, consider the small swap spreads (~0.05%) observed in current stablecoin foreign-exchange pools.

By analyzing an emblematic pool, we see that the original purpose of the simplest type of AMM has been fulfilled: the incentives for providing liquidity work as intended. We do not aim to provide comprehensive evidence for this claim in general. On the contrary, for the sake of concreteness and simplicity, we focus on [Uniswap V2's USDC/ETH pool](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc), a constant product AMM with a swap fee of 0.3%.

The goal is to illustrate several important points that deserve to be better known and understood across the broader blockchain community. Most notably, a method for analyzing past performance and estimating the future evolution of the Liquidity Provider (LP) position. Even amid the usual chaos of the crypto market, we find some strikingly predictable quantities.

## Pool long-term performance

Let us first examine the evolution of the value (measured in USD) of the LP position between January 2021 and January 2026, [five years](https://www.youtube.com/watch?v=2ObjtVdsV3I). We compare this with the value of simply holding the initial amounts of USDC and ETH. At the beginning of the period, the price of this pair was approximately 750 USDC/ETH, while at the end it reached 3000 USDC/ETH, a fourfold increase. For each initial dollar, the Hold position ends at 2.5 USD, while the LP position ends at 4.25 USD.
The following chart shows the full evolution of the price, the positions' values, and the value of the LP position relative to the Hold position.

<p align="center"> <img src="/images/quant-chart-a.png" alt="LP vs Hold" width="2000"> </p>

Let us break this down. 
A constant product AMM between two tokens always holds half of its value in each pool component. It is not truly "constant product" since the product of the reserves increases after each swap, due to the "swap fee". The performance of the LP position relative to Hold can be decomposed into two components: one that depends deterministically on the current price, and another arising from collected fees. The former always implies a loss (_divergence loss_), while the latter generates gains. The overall performance is therefore the result of this tension. 

In the chart, we can observe that for this pool and time period, there is a clear trend: the orange line consistently outperforms the blue line. The LP position ends up 70% above Hold, corresponding to an annualized return of 11%.

## Betting on predictable noise

It is customary to distinguish between _arbitrage flow_ and _organic flow_ (also called _noise flow_). However, it is impractical —or even impossible— to classify 
individual transactions as belonging to one category or the other. Fortunately, there is a relatively simple method to achieve this disaggregation. For a given price sequence, we define the pure arbitrage dynamics as the evolution the pool would experience in the sole presence of an ideal arbitrageur. This dynamic can be simulated retrospectively for the pool under consideration. Any additional flow observed beyond this baseline is, by definition, _organic flow_.

We used this method at Balancer during 2025 to study the evolution of [Autorange](https://docs.balancer.fi/concepts/explore-available-balancer-pools/autorange-pool/reclamm-pool.html) pools. The output of the simulation depends on the ratio *gas_price / liquidity*. However, since the pool is highly liquid in the case under consideration, gas costs are effectively diluted, and any reasonable estimate yields approximately the same result. 
Below, we present a chart with the results of the simulation for 2025, along with a comparison to the Hold position and the actual LP position. We also include a simulated feeless pool, which we use as the baseline for the relative value chart. Note that the feeless pool position depends only on the instantaneous price.

<p align="center"> <img src="/images/quant-chart-b.png" alt="Simulation" width="2000"> </p>

The steady pace of the green and red lines is quite remarkable! 

It means that, for this pool, we can credibly estimate the income rates from both arbitrage and organic flow simply by looking at the recent past. These have contributed approximately 5% and 6%, respectively, to the LP position's appreciation. From experience, this pattern of steady evolution is not an exception but the norm in AMMs. Of course, not every pool exhibits this level of organic flow, and in many cases price divergence hits hard. In this case, we see how much the typical noise in a cryptocurrency price signal benefits the LP, along with the so-called _noise traders_ responsible for the organic flow.

An economic agent with a model for the terminal price (e.g., a probability distribution) over a given time horizon can leverage this methodology to obtain a reliable estimate of the value of an LP position. Conversely, one can use the same data to compute the price range required at a future time to achieve a favorable outcome and estimate the probability of that event occurring.

Income from arbitrage flow is directly related to volatility. Therefore, roughly speaking, the higher its rate, the greater the risk from price divergence. By contrast, income from organic flow represents pure gain. 

Let us emphasize that the green line represents the evolution of a liquidity position in a hypothetical AMM with the same design but without any traction beyond arbitrage activity. For this reason, the methodology provides an interesting metric for assessing the performance of the pool.

## The choice of a benchmark

In the influential paper "Automated Market Making and Loss-Versus-Rebalancing", the authors propose the _Rebalancing_ position as a universal benchmark for AMMs. In short, this is a hypothetical position that evolves by executing rebalancing swaps at the market price with no fees. The _Rebalancing_ position necessarily outperforms the _Arb-only_ position (or "pure arbitrage") considered above, since the latter operates at a strictly worse price. We can add the _Rebalancing_ position to the previous plot of relative valuations during 2025.

<p align="center"> <img src="/images/quant-chart-c.png" alt="Simulation" width="500"> </p>

As expected, it also exhibits almost linear behaviour relative to _Feeless pool_.
A nice feature of the _Rebalancing_ position is that it requires no parameters other than the block frequency. Its evolution is determined by the price sequence alone. This is an advantage over the _Arb only_ benchmark, for which the gas cost must be estimated.

At this point, it is worth noting that the fact that a particular AMM performs below _Rebalancing_ does not necessarily mean that the LP is losing money in absolute terms. For instance, the LP may be interested in outperforming _Hold_ or another independent benchmark.

See also [3], [4], [5] for alternative perspectives and further data analysis on this topic.


## Pool vs. Rebalancing Under Activated Protocol Fees

_"LVR (loss-versus-rebalancing) can be used by AMM protocol designers for guidance to set fees. This is because in a competitive market for liquidity provision, there should be no excess profits for LPs, and hence fees should balance with LVR._"

The quote is taken from [2].

As we have just seen, the Uniswap v2 USDC–ETH pool significantly outperformed the _Rebalancing_ position during 2025. By the end of that year, Uniswap activated protocol fees. Since then, the original 0.3% swap fee has been split into 0.25% for the pool and 0.05% for the protocol. What has been the net effect of this modification? The answer is shown in the next chart.

<p align="center"> <img src="/images/quant-chart-d.png" alt="2026-vs-rebalancing" width="2200"> </p>

The pool's performance closely mirrors that of the _Rebalancing_ position! It looks as though the suggestion in the quote was followed intentionally.

## Final thoughts

We have seen that decentralized exchange can be profitable. Nevertheless, there is still a long road ahead: despite significant progress, a truly decentralized exchange has yet to emerge. Even if a portion of Uniswap's protocol fees are channeled to UNI token holders, the protocol itself is not decentralized. It also suffers from significant MEV ("miner extractable value") and liquidity fragmentation. 

It is the author's conviction that a truly decentralized exchange can be built. One in which token holders have direct control over the protocol, receive trading fees, and traders (including LPs) face significantly lower levels of MEV than those observed today. A similar vision is shared by many individuals and teams across the industry. In a forthcoming note, I will outline plausible design principles for such a mechanism, which should be viewed as an improvement upon the proposal presented in [8].

## References
[1] [Adams, Zinsmeister, Robinson — "Uniswap v2 Core"](https://uniswap.org/whitepaper.pdf)  
[2] [Milionis, Moallemi, Roughgarden, Zhang — "Automated Market Making and Loss-Versus-Rebalancing"](https://arxiv.org/pdf/2208.06046)  
[3] [Willetts, Harrington — "Rebalancing-versus-Rebalancing: Improving the fidelity of
Loss-versus-Rebalancing"](https://arxiv.org/abs/2410.23404)  
[4] [Fritsch, Canidio — "Measuring Arbitrage Losses and Profitability of AMM Liquidity"](https://arxiv.org/abs/2404.05803)  
[5] [Nezlobin, Nezlobina, Zinoviev — "Toxic Order Flow on Decentralized Exchanges: Problem and Solutions"](https://medium.com/@alexnezlobin/toxic-order-flow-on-decentralized-exchanges-problem-and-solutions-a1b79f32225a)  
[6] [Uniswap V2 USDC/ETH pool (Etherscan)](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc)  
[7] [Balancer Autorange Pools docs](https://docs.balancer.fi/concepts/explore-available-balancer-pools/autorange-pool/reclamm-pool.html)  
[8] [Yuhjtman — "Affiliated AMMs and permissionless solving for uniform price batch auctions"](https://ethresear.ch/t/affiliated-amms-and-permissionless-solving-for-uniform-price-batch-auctions/20187)


## Acknowledgements
I am deeply grateful to [Balancer](https://balancer.fi/), where I grew professionally over three years. Special thanks to Juan Ignacio Ubeira for his valuable feedback on an earlier draft.