const hre = require("hardhat");

async function main() {
  const TipJar = await hre.ethers.getContractFactory("TipJar");
  const tipJar = await TipJar.deploy(); // ← Deploy contract

  await tipJar.waitForDeployment(); // ← Tunggu hingga selesai deploy (versi terbaru)

  const address = await tipJar.getAddress(); // ← Ambil address dari contract

  console.log("✅ TipJar deployed to:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
