package com.vidividi.model;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;

import com.vidividi.variable.BundleDTO;


@Controller
public class BundleDAOImpl implements BundleDAO {
	
	@Inject
	private SqlSession session;
	
	@Override
	public List<BundleDTO> getBundleList(String code) {
		return this.session.selectList("bundleList", code);
	}
}
