pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Billboard
 * @dev App Billboard
 */
contract Billboard {

    struct App {
        string name;
        address owner;
        uint8[] stars;
        mapping(address => uint256) starOf;
        uint totalStar;
    }
    
    App[] public apps;
    
    constructor() public {
    }
    
    /**
     * @dev Publish an app.
     */
    function publish(string memory name) public {
        apps.push(
            App(
                name,
                msg.sender,
                new uint8[](1),0));
    }
    
    /**
     * @dev Star an app.
     */
    function star(uint appId,uint8 num) public {
        require(num>=1 && num <=5);
        require(apps[appId].starOf[msg.sender]==0);
        App storage app = apps[appId];
        app.stars.push(num);
        app.totalStar += num;
        app.starOf[msg.sender]=app.stars.length-1;
    } 
    
    /**
     * 10,5  4,4  5,3  6,2  2,1
     * 
     * 10, 4, 5, 6, 2, 0, 1, 3, 7, 8
     * 
     * @dev find top 10 app ids array.
     */
    function top() public view returns (uint[] memory topIds)
    {
        topIds = new uint[](10);
        for(uint appId=1;appId<apps.length;appId++){
          //
          uint topLast = appId<topIds.length?appId:topIds.length-1;
          if(appId>=topIds.length && apps[appId].totalStar<=apps[topIds[topLast]].totalStar){
              continue;
          }
          //
          topIds[topLast] = appId;
          for(uint i=topLast;i>0;i--){
              if(apps[topIds[i]].totalStar>apps[topIds[i-1]].totalStar){
                  uint tempAppId = topIds[i];
                  topIds[i] = topIds[i-1];
                  topIds[i-1] = tempAppId;
              }else{
                  continue;
              }
          }
        }
    }
}