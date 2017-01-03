package com.lte.dao;

import com.lte.entity.SysPriRefMenu;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/18.
 */
@Repository("sysPriRefMenu")
public interface SysPriRefMenuDao {
    boolean insertSysPriRefMenu(SysPriRefMenu sysPriRefMenu);
    boolean deleteSysPriRefMenu(SysPriRefMenu sysPriRefMenu);
    boolean updateSysPriRefMenu(SysPriRefMenu sysPriRefMenu);
    boolean deleteAllByPriId(Integer priId);
    List<SysPriRefMenu> queryByPriId(Integer priId);
}
