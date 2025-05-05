+++
date = '2025-04-28T13:28:40-03:00'
title = 'Decentralized exchange'
draft = true
+++

## Decentralized exchange

If there are two or more tokens living on a blockchain (or more precisely, on the state of a virtual machine on top of a blockchain), it makes a lot of sense to have a decentralized exchange mechanism. This refers to a mechanism that allows users to exchange those tokens by operating entirely on-chain. 

### MEV

DEX volume 650 kETH per day
MEV 685 ETH per day, can be 10%-20% more, 750 ETH.
750 / 650k = 0.001
0.115%

This goes divided by 2.
There is also the gas cost. Example:
5 usd / 10,000 usd = 0.0005, in this case we surpass 0.1%.

Trading less is a larger percentage.
Trading more, lower percentage.

Therefore, the fee is approximately between 1/2 and 1.5 of Binance fee.

Since we are working on a decentralized solution, it is reasonable to aim
to much less than 1/2, say 1/10.

We'd like a fee of around 0.01%.
Assuming uniform price, we might have a lot of volume aimed at that price impact.

For N=2 it seems possible that it's better to censor one side.

For a large difference between AMM and CEX, N=2, apparently the miner wins by MEVing.


### N = 2

One AMM (linearized function), and one order.
Or two orders (one of them a line, so that there is only one equilibrium price).

Two cases:

-Assuming same price, with a gas fee.

Compare different options for the miner

Which one is the best for the miner

-Without same price

Same options, which one is the best now.


