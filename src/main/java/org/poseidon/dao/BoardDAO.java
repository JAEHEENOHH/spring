package org.poseidon.dao;

import java.util.List;

import org.poseidon.dto.BoardDTO;
import org.poseidon.dto.CommentDTO;
import org.poseidon.dto.WriteDTO;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO extends AbstractDAO{

	public List<BoardDTO> boardList(int pageNo){
		return sqlSession.selectList("board.boardList", pageNo);
	}

	public BoardDTO detail(int no) {
		return sqlSession.selectOne("board.detail", no);
	}

	public int write(WriteDTO dto) {
		return sqlSession.insert("board.write", dto);
	}

	public int commentWrite(CommentDTO comment) {
		return sqlSession.insert("board.commentWrite", comment);
	}

	public List<CommentDTO> commentsList(int no) {
		return sqlSession.selectList("board.commentsList", no);
	}

	public int postDel(WriteDTO dto) {
		return sqlSession.update("board.postDel", dto);
	}

	public int totalRecordCount() {
		return sqlSession.selectOne("board.totalRecordCount");
	}

	public int deleteComment(CommentDTO dto) {
		return sqlSession.update("board.deleteComment", dto);
	}

	public void countUP(BoardDTO dto) {
		sqlSession.insert("board.countUP", dto);
	}

	public int alreadyRead(BoardDTO dto) {
		return sqlSession.selectOne("board.alreadyRead", dto);
	}

	public int liekUp(CommentDTO dto) {
		return sqlSession.update("board.likeUp", dto);
	}
	
}
