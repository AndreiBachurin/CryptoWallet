const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {
    const url = "http://127.0.0.1:8545/";
    const provider = new ethers.providers.JsonRpcProvider(url);
    let sender = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
    let signer = provider.getSigner(sender);
    let receiver = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";
    let amountInEther = ethers.utils.parseEther("1.0");
    let tx = {to: receiver, value: amountInEther};
    result = await signer.sendTransaction(tx);
    console.log(result);
    const balance = await signer.getBalance();
    const reveiverBalance = await provider.getBalance(receiver);
    console.log(ethers.utils.formatEther(balance));
    console.log(ethers.utils.formatEther(reveiverBalance));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});