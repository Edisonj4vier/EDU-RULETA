import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
  Put,
} from '@nestjs/common';
import { CoursesService } from './courses.service';
import { CreateCourseDto } from './dto/create-course.dto';
import { UpdateCourseDto } from './dto/update-course.dto';
import { PaginationDto } from 'src/common/dto/pagination.dto';
import { AuthGuard } from '@nestjs/passport';
import { Auth, GetUser } from 'src/auth/decorators';
import { User } from 'src/auth/entities/auth.entity';

@Controller('courses')
export class CoursesController {
  constructor(private readonly coursesService: CoursesService) {}

  @Post()
  create(@Body() createCourseDto: CreateCourseDto) {
    return this.coursesService.create(createCourseDto);
  }

  @Get()
  @Auth()
  findAll(@Query() paginationDTO: PaginationDto) {
    return this.coursesService.findAll(paginationDTO);
  }
  // Obtener todos los cursos de un usuario
  @Get('user/:userId')
  @Auth()
  findAllByUser(
    @GetUser() user: User,
    @Param('userId') userId: string,
    @Query() paginationDTO: PaginationDto,
  ) {
    return this.coursesService.findAllByUser(userId, paginationDTO);
  }

  @Get(':id')
  @Auth()
  findOne(@Param('id') id: string) {
    return this.coursesService.findOne(id);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateCourseDto: UpdateCourseDto) {
    return this.coursesService.update(id, updateCourseDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.coursesService.remove(id);
  }
}
