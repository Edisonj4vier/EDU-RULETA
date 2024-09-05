import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { StudentCourseService } from './student_course.service';
import { CreateStudentCourseDto } from './dto/create-student_course.dto';
import { UpdateStudentCourseDto } from './dto/update-student_course.dto';
import { Auth, GetUser, RoleProtected } from 'src/auth/decorators';
import { ValidRoles } from 'src/auth/interfaces';
import { AuthGuard } from '@nestjs/passport';
import { UserRoleGuard } from 'src/auth/guards';
import { User } from 'src/auth/entities/auth.entity';
import { ApiOperation, ApiParam, ApiResponse, ApiTags } from '@nestjs/swagger';
import { StudentCourse } from './entities/student_course.entity';

@ApiTags('Cursos de los estudiantes')
@Auth()
@Controller('student-course')
export class StudentCourseController {
  constructor(private readonly studentCourseService: StudentCourseService) {}

  @Post()
  @ApiOperation({ summary: 'Registrar un estudiante en un Curso' })
  @ApiResponse({
    status: 201,
    description: 'Curso del estudiante creado correctamente',
    type: StudentCourse,
  })
  @ApiResponse({ status: 400, description: 'Error de validación' })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @RoleProtected(ValidRoles.student)
  @UseGuards(AuthGuard(), UserRoleGuard)
  create(
    @Body() createStudentCourseDto: CreateStudentCourseDto,
    @GetUser() user: User,
  ) {
    return this.studentCourseService.create(createStudentCourseDto, user);
  }

  @ApiResponse({
    status: 200,
    description: 'Lista de cursos de estudiantes obtenida exitosamente',
    type: [StudentCourse],
  })
  @ApiOperation({ summary: 'Obtener un curso de un estudiante' })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @ApiParam({ name: 'id', required: true })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.studentCourseService.findOne(id);
  }

  @ApiOperation({ summary: 'Obtener todos los cursos de un estudiante' })
  @ApiResponse({
    status: 200,
    description: 'Lista de cursos de estudiantes obtenida exitosamente',
    type: [StudentCourse],
  })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @Get()
  @RoleProtected(ValidRoles.student)
  @UseGuards(AuthGuard(), UserRoleGuard)
  findAllByUser(@GetUser() user: User) {
    return this.studentCourseService.findCoursesByStudent(user);
  }

  @ApiOperation({ summary: 'Actualizar un curso de un estudiante' })
  @ApiResponse({
    status: 200,
    description: 'Curso del estudiante actualizado correctamente',
    type: StudentCourse,
  })
  @ApiResponse({ status: 400, description: 'Error de validación' })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @RoleProtected(ValidRoles.student)
  @ApiParam({ name: 'id', required: true })
  @UseGuards(AuthGuard(), UserRoleGuard)
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateStudentCourseDto: UpdateStudentCourseDto,
  ) {
    return this.studentCourseService.update(id, updateStudentCourseDto);
  }

  @ApiOperation({ summary: 'Eliminar un curso de un estudiante' })
  @ApiResponse({
    status: 200,
    description: 'Curso del estudiante eliminado correctamente',
    type: StudentCourse,
  })
  @ApiResponse({ status: 401, description: 'No autorizado' })
  @ApiResponse({ status: 403, description: 'No tiene permisos' })
  @ApiResponse({ status: 500, description: 'Error del servidor' })
  @RoleProtected(ValidRoles.student)
  @ApiParam({ name: 'id', required: true })
  @UseGuards(AuthGuard(), UserRoleGuard)
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.studentCourseService.remove(id);
  }
}
