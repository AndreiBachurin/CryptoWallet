const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {
    const contractAddr = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
    const accountAddr = "0x14dC79964da2C08b23698B3D3cc7Ca32193d9955";
    const signer = ethers.provider.getSigner(accountAddr);
    const Wallet = await ethers.getContractFactory("Wallet", signer);
    const wallet = await Wallet.deploy();
    await wallet.deployed;

    console.log("Wallet address (contract): ", wallet.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});