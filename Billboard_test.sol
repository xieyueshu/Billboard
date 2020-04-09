pragma solidity >=0.4.0 <0.7.0;
      import "remix_tests.sol"; // this import is automatically injected by Remix.
      
      import "Billboard.sol";

      // file name has to end with '_test.sol'
      contract Billboard_test_1 {
          
        Billboard billboard;

        string[] names = ["N1","N2","N3","N4","N5","N6","N7","N8","N9","N10", "N11","N12","N13"];

        uint[] starAppIds = [10,4,5,6,2];
        uint8[] appStars = [5,4,3,2,1];

        function beforeAll() public {
          // here should instantiate tested contract
            billboard = new Billboard();
          for(uint i=0;i<names.length;i++){
            
            billboard.publish(names[i]);
          }
          for(uint i=0;i<starAppIds.length;i++){
            billboard.star(starAppIds[i],appStars[i]);
          }
        }

        function checkStar() public returns (bool) {
          // use 'Assert' to test the contract
          for(uint i=0;i<starAppIds.length;i++){
            (,,uint appTotalStar) = billboard.apps(starAppIds[i]);
            Assert.equal(appTotalStar, appStars[i], "Star set error.");
          }
          return true;
        }

        function checkTop() public returns (bool) {
          // use the return value (true or false) to test the contract
          uint[] memory topAppIds = billboard.top();
          for(uint i=0;i<starAppIds.length;i++){
            Assert.equal(topAppIds[i], starAppIds[i], "Top order error.");
          }
          return true;
        }
      }

