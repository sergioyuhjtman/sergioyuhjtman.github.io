+++
date = '2026-04-01T12:00:00-00:00'
title = 'A simple but powerful approach to the quantitative study of AMMs'
draft = false
+++

# A simple but powerful approach to the quantitative study of AMMs 

<br>

*Abstract: We explain how to measure income from organic flow in an Automated Market Maker (AMM) and present selected results, focusing on a particular pool. We argue for the relevance of this metric and take the opportunity to discuss related concepts.*
<br>

## Introduction

Ultimately, this article is about Decentralized Exchange (DEX). In an ideal world, a human should be able to exchange money almost instantly without intermediaries, other than a blockchain that charges gas costs and a tiny swap fee (say, 0.01%). Of course, this DEX utopia wouldn't solve famines, poverty or wars, but it is a significant economic problem that we can tackle and perhaps even solve. To some extent, the content here serves as a reminder that we have made substantial progress toward this goal. This reminder comes in a particular form: a sharp look at the most basic type of AMM. I aim to present some simple but relevant results and methodology for the quantitative study of AMMs.

For the sake of concreteness and simplicity, we focus on a specific and emblematic AMM: [Uniswap V2's USDC/ETH pool](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc). This is a constant product AMM with a swap fee of 0.3%. The data shared here illustrates several important points that, in my view, deserve to be better known and understood across the broader blockchain community.

## Pool long-term performance

Let us first examine the evolution of the value (measured in USD) of a liquidity provider (LP) position between January 2021 and January 2026, [five years](https://www.youtube.com/watch?v=2ObjtVdsV3I). We compare this with the value of simply holding the initial amounts of USDC and ETH. At the beginning of the period, the price of this pair was approximately 750 USDC/ETH, while at the end it reached 3000 USDC/ETH, a fourfold increase. For each initial dollar, the Hold position ends at 2.5 USD, while the LP position ends at 4.25 USD.
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

It suggests that, for this pool, we can credibly estimate the income rates from both arbitrage and organic flow simply by looking at the recent past. These have contributed approximately 5% and 6%, respectively, to the LP position's appreciation. From experience, this pattern of steady growth is not an exception but the norm in AMMs. Of course, not every pool exhibits this level of organic flow, and in many cases price divergence hits hard. In this case, we see how much the typical noise in a cryptocurrency price signal benefits the LP, along with the so-called _noise traders_ responsible for the organic flow.

An economic agent with a model for the final price (e.g., a probability distribution) over a given time horizon can leverage this methodology to obtain a good estimate for the LP position.

Income from arbitrage flow is directly related to volatility. Therefore, roughly speaking, the higher the rate, the greater the risk from price divergence. By contrast, income from organic flow represents pure gain. For this reason, it is a metric that deserves wider attention. More generally, I believe that this simple perspective and methodology can make AMM liquidity provision more transparent to a broader audience, and hopefully attract more participants to the DEX ecosystem.

## Contrast with other points of view

Please compare the exposition above with the following paragraph:

"AMM is a weird mix of a bad fund manager (who runs a rebalancing portfolio that loses money for any price movement) and a bad market maker (who loses money on every trade, and wishes to win it back in fees)"

This is the opening of a [tweet](https://x.com/StanleyHe17/status/2038346843764002876) by a respected member of the community. I have heard this kind of opinion many times. Apparently, some view AMMs as naive agents that allow arbitrageurs to take advantage of them, and therefore the expected utility is always negative for LPs. But the truth is that arbitrageurs and LPs do not play a zero-sum game with each other. On the contrary, LPs are actually favored by efficient arbitrage, so there is cooperation. 

This social phenomenon seems to be causally connected to the highly influential literature on [*loss versus rebalancing*](https://arxiv.org/pdf/2208.06046) (LVR). While the concept is technically well defined and relevant, it is not the only factor. Moreover, it is not always necessary to consider it in order to make a sound quantitative assessment of an LP position. In our example, we can simulate the *rebalancing* position by donating arbitrage profits to the pool. The result is a gain of approximately 2% compared to the arb-only simulation shown in the chart above. This 2% is the *loss* of the arb-only position *vs. rebalancing*.

But then, is it possible to eliminate LVR and achieve better AMM performance? My impression is that one cannot sustainably have both non-LVR and noise-flow-receiving AMMs. That would seem excessively favorable to LPs relative to other traders, who could simply opt out. In the future, I expect AMMs to replace noise flow with non-LVR. More on this [here](https://ethresear.ch/t/affiliated-amms-and-permissionless-solving-for-uniform-price-batch-auctions/20187).

See also these two articles: <br>
[Measuring Arbitrage Losses and Profitability of AMM Liquidity](https://arxiv.org/abs/2404.05803) <br>
[Toxic Order Flow on Decentralized Exchanges: Problem and Solutions](https://medium.com/@alexnezlobin/toxic-order-flow-on-decentralized-exchanges-problem-and-solutions-a1b79f32225a) 
<br>
for more quantitative analysis of AMMs.


### References
- [Adams, Zinsmeister, Robinson — "Uniswap v2 Core"](https://uniswap.org/whitepaper.pdf)
- [Milionis, Moallemi, Roughgarden, Zhang — "Automated Market Making and Loss-Versus-Rebalancing"](https://arxiv.org/pdf/2208.06046)
- [Yuhjtman — "Affiliated AMMs and permissionless solving for uniform price batch auctions"](https://ethresear.ch/t/affiliated-amms-and-permissionless-solving-for-uniform-price-batch-auctions/20187)
- [Fritsch, Canidio — "Measuring Arbitrage Losses and Profitability of AMM Liquidity"](https://arxiv.org/abs/2404.05803)
- [Nezlobin, Nezlobina, Zinoviev — "Toxic Order Flow on Decentralized Exchanges: Problem and Solutions"](https://medium.com/@alexnezlobin/toxic-order-flow-on-decentralized-exchanges-problem-and-solutions-a1b79f32225a)
- [Uniswap V2 USDC/ETH pool (Etherscan)](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc)
- [Balancer ReClamm pool docs](https://docs.balancer.fi/concepts/explore-available-balancer-pools/reclamm-pool/reclamm-pool.html)


### Acknowledgements
I am deeply grateful to [Balancer](https://balancer.fi/), where I grew professionally over three years.


