Address: fuel1cglu4tezz3sdcw82l64qkfwtltldhvk49qepvhs6pj5sf64ss9vqlpf20l

# ethsamba-hack-contracts

## Happay
Happay people, Happay workplace

<table>
  <tr>
    <td><img src="docs/Screenshot 2023-04-02 at 08.49.45.png" width="100%"/></td>
    <td><img src="docs/Screenshot 2023-04-02 at 08.49.55.png" width="100%"/></td>
    <td><img src="docs/Screenshot 2023-04-02 at 08.50.08.png" width="100%"/></td>
  </tr>
</table>

## Contracts

Local Contract address: 0xa3cff3de3cf287c31854645a7c842598d992432ee24acc66d48fd9b011e8f85d

Neste repositorio voce encontrara os contratos utilizados para interagir com a Fuel Network

## - Write and deploy a smart contract in Sway. 

- Utilizamos Docker para fazer o deploy local dos contratos e tambem pedir Faucet localmente

```
forc wallet account new
forc deploy --gas-price 1 --random-salt
forc-wallet sign --account 0 tx-id 75a39a3392f1ce392dce0d8b212faeda592e39faa8cea767502ec273d4e1c6ad
npx fuels typegen -i ~/Projetos/ethsamba-hack-backend/token_contract/out/debug/token_contract-abi.json -o ~/Projetos/ethsamba-hack-front/src/types
```

- `token_abi` interface que contem todos os metodos que utilizamos no outro contrato que fizemos deploy
- `token_contract` é a pasta que contém o contrato de fato que faz o mint dos tokens na carteira do empregado


## Best full-stack dApp on fuel 

- Voce consegue ver como ficou a UI acessando o link <a href="https://happay.surge.sh" target="_blank">happay.surge.sh</a>, mas ela não vai funcionar devido ao contrato ter sido feito deploy na rede docker local (como sugerido pelo Luis)

## Write a smart contract and build a UI using the typescript SDK and browser wallet. 

- Aqui está a implementação exata da função `mint` que cria os tokens diretamente na carteira do empregado
    - https://github.com/BrunoEleodoro/ethsamba-hack-contracts/blob/main/token_contract/src/main.sw#L74-L77

## Fuel network environment with a Faucet API

We enable developers to run locally a entire env with a
`fuel-core` network and `faucet` api running together

### Environment variables

| name             | default     | description                                                                                                          |
| ---------------- | ----------- | -------------------------------------------------------------------------------------------------------------------- |
| ENVIRONMENT      | development | This is used to append on volume and container name to enable multiple envs like test                                |
| WALLET_SECRET    |             | Secret used on the faucet API, by default we use the same `privateKey` used on the genesis config `chainConfig.json` |
| FUEL_CORE_PORT   | 4000        | Fuel network PORT                                                                                                    |
| FUEL_FAUCET_PORT | 4040        | Faucet API PORT                                                                                                      |
| DISPENSE_AMOUNT  | 50000000    | Faucet dispense amount                                                                                               |
| GAS_PRICE        | 1           | Set Fuel Core `--min-gas-price`                                                                                      |
