package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.BundleDTO;

public interface BundleDAO {
	public List<BundleDTO> getBundleList(String code);
}
