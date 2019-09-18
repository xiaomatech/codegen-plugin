package ${package};

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.RandomUtils;
import org.springframework.util.ReflectionUtils;

import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

public class DomainUtils {

    public static <T> T newRandomInstance(Class<T> clazz) {
        return newRandomInstance(clazz,false);
    }
    public static <T> T newRandomInstance(Class<T> clazz, boolean withFk) {
        try{
            T obj = clazz.newInstance();
            Field[] fields =  clazz.getDeclaredFields();
            for (Field f: fields){
                ReflectionUtils.makeAccessible(f);
                String type = f.getType().getTypeName();
                String name = f.getName();
                if("id".equals(name)){
                    continue;
                }
                Object val = null;
                DecimalFormat df = new DecimalFormat("#.00");
                if(Integer.class.getTypeName().equals(type)){
                    if("enable".equals(name)){
                        val = RandomUtils.nextInt(0,1);
                    }else{
                        val =RandomUtils.nextInt(20,100);
                    }
                }else if(String.class.getTypeName().equals(type)){
                    val = name +"-"+ RandomStringUtils.randomAlphabetic(5);
                }else if(Float.class.getTypeName().equals(type)){
                    val = RandomUtils.nextFloat(5,10);
                }else if(Double.class.getTypeName().equals(type)){
                    val = RandomUtils.nextDouble(10,20);
                    val = df.format(val);
                }else if(Long.class.getTypeName().equals(type)){
                    val = RandomUtils.nextLong(30,50);
                }else if(Date.class.getTypeName().equals(type)){
                    val = new Date();
                }else if(BigDecimal.class.getTypeName().equals(type)){
                    String str = df.format(RandomUtils.nextDouble(3,5));
                    val = new BigDecimal(str);
                }else{
                    val = null;
                    //如有非空注解,强制创建对象
                    if(f.isAnnotationPresent(NotNull.class) && f.isAnnotationPresent(ManyToOne.class)){
                        val = newRandomInstance(Class.forName(type),false);
                    }else if(withFk && !List.class.getTypeName().equals(type)){
                        val = newRandomInstance(Class.forName(type),false);
                    }
                }
                ReflectionUtils.setField(f,obj,val);
            }
            return obj;
        }catch (Exception e){
            return null;
        }
    }
}

