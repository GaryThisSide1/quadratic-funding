pragma ever-solidity >= 0.35.0;
pragma AbiHeader expire;


contract Wallet {
    
    uint128 matchingvaluee;
    mapping(address => string) public projects;
	mapping(address => uint) public numberOfProjectOfEachAddress;
	mapping(string => uint)  numberOfProjects;
	mapping(string => uint) NumbersOfFunder;
	mapping(string => uint) fundsOfEachProject;
	uint total;
	uint128 balance;
	address owner;
	uint256 start;
	uint256 end;
	string[] public arr;
	
    constructor(uint128 Matching_value,uint _startt,uint _endt) public {
        
	start=_startt;
	end=_endt;
	matchingvaluee=Matching_value;
        require(tvm.pubkey() != 0, 101);
        
        require(msg.pubkey() == tvm.pubkey(), 102);
		
	owner=msg.sender;
        tvm.accept();
    }

    
    modifier checkOwnerAndAccept {
        
        require(msg.pubkey() == tvm.pubkey(), 100);

		
	tvm.accept();
	_;
}
    modifier onlyOwner {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }
    
	function project(string name) public checkOwnerAndAccept{
	   numberOfProjectOfEachAddress[msg.sender]+=1;
	   projects[msg.sender]=name;
	   numberOfProjects[name]+=1;
	}
	
	function withdraw(string nam) public  checkOwnerAndAccept{
		require(block.timestamp>start,404);
		require(block.timestamp<end,403);
		require(projects[msg.sender]==nam);
		uint i=NumbersOfFunder[nam]*matchingvaluee;
		tvm.accept();
		msg.sender.transfer(uint128(i/total));
		NumbersOfFunder[nam]=0;
		total-=1;
	}
	
	function deposit(uint i,string name) public checkOwnerAndAccept{
		NumbersOfFunder[name]+=1;
		total+=1;
		fundsOfEachProject[name]+=i;
		balance += uint128(i);
	}
    
}
