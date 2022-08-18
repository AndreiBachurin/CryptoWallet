const hre = require("hardhat");
const walletArtifact = require("../artifacts/contracts/Wallet.sol/Wallet.json")
const ethers = hre.ethers;

async function main() {
    const contractAddr = "0xef11D1c2aA48826D4c41e54ab82D1Ff5Ad8A64Ca";
    const accountAddr = "0x14dC79964da2C08b23698B3D3cc7Ca32193d9955";
    const signer = ethers.provider.getSigner(accountAddr);
    // let amountInEther = ethers.utils.parseEther("1.0");
    // let tx = {to: contractAddr, value: amountInEther};
    // result = await signer.sendTransaction(tx);
    // console.log(result);
    const contract = new ethers.Contract(contractAddr, walletArtifact.abi, signer);
    let txWithdraw = await contract.withdrawMoney(ethers.utils.parseEther("1.0"));
    console.log(txWithdraw);
    contractBalance = await contract.getBalance();
    console.log(ethers.utils.formatEther(contractBalance));
    // const owner = await contract.owner();
    // console.log(owner);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});