package ${package+'.exception'};

import ${package}.common.Result;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

/**
 * 异常处理器
 *
 */
@RestControllerAdvice
@Slf4j
public class BaseExceptionHandler {

	/**
	 * 处理自定义异常
	 */
	@ExceptionHandler(BaseException.class)
	public Result<?> handleRRException(BaseException e){
		log.error(e.getMessage(), e);
		return Result.error(e.getMessage());
	}

	@ExceptionHandler(NoHandlerFoundException.class)
	public Result<?> handlerNoFoundException(Exception e) {
		log.error(e.getMessage(), e);
		return Result.error(404, "路径不存在，请检查路径是否正确");
	}

	@ExceptionHandler(DuplicateKeyException.class)
	public Result<?> handleDuplicateKeyException(DuplicateKeyException e){
		log.error(e.getMessage(), e);
		return Result.error("数据库中已存在该记录");
	}

	@ExceptionHandler(Exception.class)
	public Result<?> handleException(Exception e){
		log.error(e.getMessage(), e);
		return Result.error(e.getMessage());
	}


	/**
	  * spring默认上传大小100MB 超出大小捕获异常MaxUploadSizeExceededException
	*/
   	@ExceptionHandler(MaxUploadSizeExceededException.class)
    	public Result<?> handleMaxUploadSizeExceededException(MaxUploadSizeExceededException e) {
    		log.error(e.getMessage(), e);
        	return Result.error("文件大小超出10MB限制, 请压缩或降低文件质量! ");
    	}

}
