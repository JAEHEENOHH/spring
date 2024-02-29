package org.poseidon.service;

import org.poseidon.dao.LoginDAO;
import org.poseidon.dto.LoginDTO;
import org.poseidon.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService  extends AbstractService {

	@Autowired
	private LoginDAO loginDAO;
	
	public LoginDTO login(LoginDTO dto) {
		return loginDAO.login(dto);
	}

	public void mcountUp(LoginDTO loginDTO) {
		loginDAO.mcountUp(loginDTO);
	}

	public void mcountReset(LoginDTO loginDTO) {
		loginDAO.mcountReset(loginDTO);
	}

	public int join(MemberDTO join) {
		return loginDAO.join(join);
	}



		
	
}