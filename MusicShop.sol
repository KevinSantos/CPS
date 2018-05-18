pragma solidity ^0.4.23;

contract MusicShop{
    
    struct Product{
        uint stock;
        uint price;
        string name;
    }
    
    address owner;
    mapping(uint => Product) products;
    
    constructor() payable{
        owner = msg.sender;
    }
    
    function getProduct(uint _productId) constant returns (uint, uint, string){
        return (products[_productId].stock, products[_productId].price, products[_productId].name);
    }
    
    function buyProduct(uint _productId, uint _amount) payable{
        require(msg.value == _amount * products[_productId].price);
        decrementStock(_productId, _amount);
    }
    
    
    /// PRIVATE FUNCTIONS
    function decrementStock(uint _productId, uint _amount) private{
        assert(products[_productId].stock >= _amount);
        products[_productId].stock -= _amount;
    }
    
    /// FUNCTIONS FOR OWNER
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function addProduct(uint _productId, uint _stock, uint _price, string _name) onlyOwner{
        products[_productId].stock = _stock;
        products[_productId].price = _price;
        products[_productId].name = _name;
    }
    
    function incrementStock(uint productId, uint amount) onlyOwner{
        products[productId].stock += amount;
    }
    
    function closeShop() onlyOwner{
        selfdestruct(owner);
    }
}

