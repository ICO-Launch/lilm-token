const Proxy = artifacts.require('./Proxy.sol');
const Controller = artifacts.require('./LockedToken.sol');

const decimals = 18;
const initCap = 10000000000000;

module.exports = async function(deployer) {
    // deploy proxy
    await deployer.deploy(Proxy);
    const proxy = await Proxy.deployed();
    // deploy controller
    await deployer.deploy(Controller);
    const controller = await Controller.deployed();
    // create binding of proxy with controller interface
    let token = Controller.at(proxy.address);
    // use binding
    await token.initialize(controller.address, initCap*(10**decimals));
    // saleLock enabled
    await token.setLock(true);
    // check result
    let cap = await token.cap();
    console.log(cap.toNumber());
};
