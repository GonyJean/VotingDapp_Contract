// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    struct Vote {
        address voter;
        bool choice;
    }
    struct Poll {
        string question;
        string imgUrl;
        Vote[] votes;
        mapping(address => bool) hasVoted;
    }
    struct pollsListObj {
        string name;
        uint256 yesCount;
        uint256 noCount;
        string imgUrl;
    }

    Poll[] public polls;
    // 创建投票
    function createPoll(string memory question, string memory imgUrl) public {
        // 直接创建新的投票，映射`hasVoted`会自动初始化为空
        Poll storage newPoll = polls.push();
        newPoll.question = question;
        newPoll.imgUrl = imgUrl;
    }
    // 投票动作
    function vote(uint256 pollIndex, bool choice) public {
        Poll storage poll = polls[pollIndex];
        require(!poll.hasVoted[msg.sender], "You have already voted.");
        Vote memory newVote = Vote({voter: msg.sender, choice: choice});
        poll.votes.push(newVote);
        poll.hasVoted[msg.sender] = true;
    }
    // 根据index取投票信息
    function getPollResults(uint256 pollIndex)
        public
        view
        returns (
            uint256 yes,
            uint256 no,
            uint256 CurrentIndex
        )
    {
        Poll storage poll = polls[pollIndex];
        uint256 yesCount = 0;
        uint256 noCount = 0;
        for (uint256 i = 0; i < poll.votes.length; i++) {
            if (poll.votes[i].choice) {
                yesCount++;
            } else {
                noCount++;
            }
        }
        return (yesCount, noCount, pollIndex);
    }

    // 返回数组长度
    function getPollsCount() public view returns (uint256) {
        return polls.length;
    }

    // 获取所有投票的统计信息 用于绘制列表页
    // TODO: 是否有更效率的方式？
    function getAllPollResults() public view returns (pollsListObj[] memory) {
        pollsListObj[] memory pollsList = new pollsListObj[](polls.length);
        // pollsListObj[] memory pollsList = new pollsListObj[];
        for (uint256 i = 0; i < polls.length; i++) {
            // 解构每个投票item
            (
                uint256 yesCount,
                uint256 noCount,
                // uint256 currentIndex
            ) = getPollResults(i);

            pollsList[i] = pollsListObj({
                name: polls[i].question,
                yesCount: yesCount,
                noCount: noCount,
                imgUrl: polls[i].imgUrl
            });
        }
        return pollsList;
    }
}
