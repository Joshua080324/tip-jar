// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TipJar {
    address public owner;

    event TipReceived(address indexed from, uint256 amount);
    event Withdrawn(uint256 amount);

    constructor() {
        // Saat kontrak di-deploy, penyebarnya (msg.sender) jadi owner
        owner = msg.sender;
    }

    // Fungsi khusus untuk menerima ETH : ketika seseorang mengirim ETH langsung ke address kontrak
    receive() external payable {
        emit TipReceived(msg.sender, msg.value);
    }

    function withdraw() external {
        // Hanya owner yang boleh menarik saldo
        require(msg.sender == owner, "Not the owner");

        uint256 amount = address(this).balance;
        require(amount > 0, "No balance to withdraw");

        // Kirim seluruh balance ke owner
        (bool success, ) = payable(owner).call{value: amount}("");
        require(success, "Withdrawal failed");

        emit Withdrawn(amount);
    }

    // Agar kita bisa baca saldo kontrak dari frontend
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
