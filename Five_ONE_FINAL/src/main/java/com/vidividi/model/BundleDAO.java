package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.BundleDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface BundleDAO {
	public List<BundleDTO> getBundleList(String ownerCode); // 재생목록 리스트
	
	public int bundleAdd(BundleDTO bundledto); // 재생목록 추가
	
	public int bundleDel(String bundleCode);
}
