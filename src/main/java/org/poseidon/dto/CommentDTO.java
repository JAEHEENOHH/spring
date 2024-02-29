package org.poseidon.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDTO {
	private int no, board_no, clike, mno;
	private String comment, mid, cdate, mname, cip;
}
