package com.util;

import java.rmi.RemoteException;

import com.demo.CalculatorProxy;

public class CallWebService {

	public static void main(String[] args) {
		CalculatorProxy proxy = new CalculatorProxy();
		try {
			System.out.println(proxy.addition(10, 20));
		} catch (RemoteException e) {
			e.printStackTrace();
		}
	}

}
