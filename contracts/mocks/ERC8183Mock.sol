// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC8183Mock {
    enum TaskState { Open, Funded, Submitted, Terminal }
    
    struct Task {
        uint256 id;
        address client;
        address provider;
        uint256 budget;
        TaskState state;
        bytes metadata;
    }
    
    mapping(uint256 => Task) public tasks;
    uint256 public nextTaskId;
    
    event TaskCreated(uint256 indexed taskId, address indexed client, uint256 budget);
    event TaskFunded(uint256 indexed taskId, address indexed provider);
    event TaskSubmitted(uint256 indexed taskId, bytes deliveryProof);
    event TaskCompleted(uint256 indexed taskId);
    
    function createTask(uint256 budget, bytes calldata metadata) external returns (uint256) {
        uint256 taskId = nextTaskId++;
        tasks[taskId] = Task({
            id: taskId,
            client: msg.sender,
            provider: address(0),
            budget: budget,
            state: TaskState.Open,
            metadata: metadata
        });
        
        emit TaskCreated(taskId, msg.sender, budget);
        return taskId;
    }
    
    function fundTask(uint256 taskId) external payable {
        Task storage task = tasks[taskId];
        require(task.state == TaskState.Open, "ERC8183Mock: task not open");
        require(msg.value >= task.budget, "ERC8183Mock: insufficient funds");
        
        task.state = TaskState.Funded;
        task.provider = msg.sender;
        emit TaskFunded(taskId, msg.sender);
    }
    
    function submitTask(uint256 taskId, bytes calldata deliveryProof) external {
        Task storage task = tasks[taskId];
        require(task.state == TaskState.Funded, "ERC8183Mock: task not funded");
        require(msg.sender == task.provider, "ERC8183Mock: not provider");
        
        task.state = TaskState.Submitted;
        emit TaskSubmitted(taskId, deliveryProof);
    }
    
    function completeTask(uint256 taskId) external {
        Task storage task = tasks[taskId];
        require(task.state == TaskState.Submitted, "ERC8183Mock: task not submitted");
        
        task.state = TaskState.Terminal;
        payable(task.client).transfer(task.budget);
        
        emit TaskCompleted(taskId);
    }
}
