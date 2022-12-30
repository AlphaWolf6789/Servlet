package com.demo;

public class CalculatorProxy implements com.demo.Calculator {
  private String _endpoint = null;
  private com.demo.Calculator calculator = null;
  
  public CalculatorProxy() {
    _initCalculatorProxy();
  }
  
  public CalculatorProxy(String endpoint) {
    _endpoint = endpoint;
    _initCalculatorProxy();
  }
  
  private void _initCalculatorProxy() {
    try {
      calculator = (new com.demo.CalculatorServiceLocator()).getCalculator();
      if (calculator != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)calculator)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)calculator)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (calculator != null)
      ((javax.xml.rpc.Stub)calculator)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.demo.Calculator getCalculator() {
    if (calculator == null)
      _initCalculatorProxy();
    return calculator;
  }
  
  public int addition(int a, int b) throws java.rmi.RemoteException{
    if (calculator == null)
      _initCalculatorProxy();
    return calculator.addition(a, b);
  }
  
  
}