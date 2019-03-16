pragma solidity >=0.4.21 <0.6.0;

contract Voting {
    
    // 候选人票数
    mapping(bytes32 => uint8) public votesReceived;
    // 投票人是否已经投票
    mapping(address => bool) public votesIsTrue;

    // 候选人数组
    bytes32[] public candidateList;

    // 检查投票人是否在候选人中
    modifier validCandidate(bytes32 candidate) {
        bool tag = false;
        for(uint i = 0; i < candidateList.length; i++) {
            if(candidateList[i] == candidate) {
                tag = true;
            }
        }
        require(tag, "符合条件");
        _;
    }

    // 初始化候选人的姓名
    constructor(bytes32[] memory candidateNames) public {
        candidateList = candidateNames;
    }

    // 查询某个候选人的总票数
    function totalVotesFor(bytes32 candidate) public validCandidate(candidate) view returns (uint8) {
        return votesReceived[candidate];
    }

    // 投票
    function voteForCandidate(bytes32 candidate) public validCandidate(candidate) returns (bool){
        // 验证是否投票了
        if(votesIsTrue[msg.sender]) {
            return false;
        }else{
            votesReceived[candidate] += 1;
            votesIsTrue[msg.sender] = true;
            return true;
        }
    }

}