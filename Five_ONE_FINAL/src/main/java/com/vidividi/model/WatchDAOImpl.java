package com.vidividi.model;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.VideoPlayDTO;

@Repository
public class WatchDAOImpl implements WatchDAO {

	@Inject
	private SqlSessionTemplate sqlSession;

	@Override
	public VideoPlayDTO getVideo(int video_code) {
		
		return this.sqlSession.selectOne("getVideo", video_code);
	}

	@Override
	public List<VideoPlayDTO> getVideoList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ReplyDTO getReply() {
		// TODO Auto-generated method stub
		return null;
	}

	
}
