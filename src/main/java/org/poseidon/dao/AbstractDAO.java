package org.poseidon.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

//부모형태로 존재하게 하겠습니다.
//@없어요.
//2024-02-26 psd 
public class AbstractDAO {

	@Autowired
	SqlSession sqlSession;
	
}
